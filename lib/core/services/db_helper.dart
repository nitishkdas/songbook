import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/song.dart';
import '../models/lyrics_block.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('datav2.sqlite');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    debugPrint('[DbHelper] Initializing database: $filePath');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    debugPrint('[DbHelper] Database path: $path');

    // Check if database exists
    final exists = await databaseExists(path);
    debugPrint('[DbHelper] Database exists: $exists');

    if (!exists) {
      // Copy database from assets
      try {
        debugPrint('[DbHelper] Copying database from assets...');
        await Directory(dirname(path)).create(recursive: true);
        final data = await rootBundle.load('data/datav2.sqlite');
        final bytes = data.buffer.asUint8List();
        await File(path).writeAsBytes(bytes);
        debugPrint('[DbHelper] Database copied successfully (${bytes.length} bytes)');
      } catch (e) {
        debugPrint('[DbHelper] Error copying database: $e');
        // If asset doesn't exist, create empty database
        debugPrint('[DbHelper] Creating empty database...');
        return await openDatabase(
          path,
          version: 1,
          onCreate: _createDB,
        );
      }
    }

    debugPrint('[DbHelper] Opening database...');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS bodosong (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        char TEXT,
        song_title TEXT,
        lyric TEXT,
        suggest_intent_data_id INTEGER,
        favorite INTEGER DEFAULT 0
      )
    ''');
  }

  // Get all songs
  Future<List<Song>> getAllSongs() async {
    try {
      debugPrint('[DbHelper] Getting all songs...');
      final db = await database;
      final result = await db.query(
        'bodosong',
        orderBy: 'char ASC, song_title ASC',
      );
      debugPrint('[DbHelper] Found ${result.length} songs');
      
      final songs = <Song>[];
      for (var i = 0; i < result.length; i++) {
        try {
          final map = result[i];
          final song = Song.fromMap(map);
          songs.add(song);
        } catch (e, stackTrace) {
          debugPrint('[DbHelper] Error parsing song at index $i: $e');
          debugPrint('[DbHelper] Stack trace: $stackTrace');
        }
      }
      
      debugPrint('[DbHelper] Successfully parsed ${songs.length} songs');
      return songs;
    } catch (e, stackTrace) {
      debugPrint('[DbHelper] Error in getAllSongs: $e');
      debugPrint('[DbHelper] Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get songs by character
  Future<List<Song>> getSongsByChar(String char) async {
    final db = await database;
    final result = await db.query(
      'bodosong',
      where: 'char = ?',
      whereArgs: [char],
      orderBy: 'song_title ASC',
    );
    return result.map((map) => Song.fromMap(map)).toList();
  }

  // Get favorite songs
  Future<List<Song>> getFavoriteSongs() async {
    final db = await database;
    final result = await db.query(
      'bodosong',
      where: 'favorite = ?',
      whereArgs: [1],
      orderBy: 'song_title ASC',
    );
    return result.map((map) => Song.fromMap(map)).toList();
  }

  // Search songs
  Future<List<Song>> searchSongs(String query) async {
    final db = await database;
    final cleanQuery = query.trim();
    
    if (cleanQuery.isEmpty) return [];

    // Check if query is a number (for ID search)
    final isNumeric = int.tryParse(cleanQuery) != null;
    
    if (isNumeric) {
      // Search by ID, title, and lyrics
      final id = int.tryParse(cleanQuery);
      final result = await db.query(
        'bodosong',
        where: 'id = ? OR song_title LIKE ? OR lyric LIKE ?',
        whereArgs: [id, '%$cleanQuery%', '%$cleanQuery%'],
        orderBy: 'song_title ASC',
      );
      return result.map((map) => Song.fromMap(map)).toList();
    } else {
      // Search only in title and lyrics using keywords
      final words = cleanQuery.split(RegExp(r'\s+'));
      final whereClauses = <String>[];
      final whereArgs = <dynamic>[];

      for (final word in words) {
        whereClauses.add('song_title LIKE ?');
        whereArgs.add('%$word%');
      }

      final result = await db.query(
        'bodosong',
        where: whereClauses.join(' AND '),
        whereArgs: whereArgs,
        orderBy: 'song_title ASC',
      );
      return result.map((map) => Song.fromMap(map)).toList();
    }
  }

  // Get song by ID
  Future<Song?> getSongById(int id) async {
    try {
      debugPrint('[DbHelper] Getting song by ID: $id');
      final db = await database;
      final result = await db.query(
        'bodosong',
        where: 'id = ?',
        whereArgs: [id],
      );
      debugPrint('[DbHelper] Query result: ${result.length} rows');
      if (result.isEmpty) {
        debugPrint('[DbHelper] No song found with ID: $id');
        return null;
      }
      final song = Song.fromMap(result.first);
      debugPrint('[DbHelper] Successfully parsed song: ${song.songTitle}');
      return song;
    } catch (e, stackTrace) {
      debugPrint('[DbHelper] Error in getSongById: $e');
      debugPrint('[DbHelper] Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Toggle favorite
  Future<void> toggleFavorite(int id, bool favorite) async {
    final db = await database;
    await db.update(
      'bodosong',
      {'favorite': favorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all unique characters
  Future<List<String>> getAllChars() async {
    try {
      debugPrint('[DbHelper] Getting all unique characters...');
      final db = await database;
      final result = await db.rawQuery(
        'SELECT DISTINCT char FROM bodosong WHERE char IS NOT NULL ORDER BY char ASC',
      );
      debugPrint('[DbHelper] Found ${result.length} unique characters');
      final chars = result.map((row) => row['char']?.toString() ?? '').where((c) => c.isNotEmpty).toList();
      debugPrint('[DbHelper] Characters: $chars');
      return chars;
    } catch (e, stackTrace) {
      debugPrint('[DbHelper] Error in getAllChars: $e');
      debugPrint('[DbHelper] Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get total song count
  Future<int> getSongCount() async {
    try {
      debugPrint('[DbHelper] Getting song count...');
      final db = await database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM bodosong');
      final count = result.first['count'] as int;
      debugPrint('[DbHelper] Total songs: $count');
      return count;
    } catch (e, stackTrace) {
      debugPrint('[DbHelper] Error in getSongCount: $e');
      debugPrint('[DbHelper] Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get lyrics blocks for a song
  Future<List<LyricsBlock>> getLyricsBlocks(int songId) async {
    try {
      debugPrint('[DbHelper] Getting lyrics blocks for song ID: $songId');
      final db = await database;
      final result = await db.query(
        'lyrics_block',
        where: 'song_id = ?',
        whereArgs: [songId],
        orderBy: 'position ASC',
      );
      debugPrint('[DbHelper] Found ${result.length} lyrics blocks');
      return result.map((map) => LyricsBlock.fromMap(map)).toList();
    } catch (e, stackTrace) {
      debugPrint('[DbHelper] Error in getLyricsBlocks: $e');
      debugPrint('[DbHelper] Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

