class LyricsBlock {
  final int id;
  final int songId;
  final String type; // 'verse' or 'chorus'
  final int? verseNumber; // NULL for chorus
  final int position;
  final String text;

  LyricsBlock({
    required this.id,
    required this.songId,
    required this.type,
    this.verseNumber,
    required this.position,
    required this.text,
  });

  factory LyricsBlock.fromMap(Map<String, dynamic> map) {
    int? toInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return LyricsBlock(
      id: toInt(map['id']) ?? 0,
      songId: toInt(map['song_id']) ?? 0,
      type: map['type']?.toString() ?? 'verse',
      verseNumber: toInt(map['verse_number']),
      position: toInt(map['position']) ?? 0,
      text: map['text']?.toString() ?? '',
    );
  }

  bool get isChorus => type == 'chorus';
  bool get isVerse => type == 'verse';
}
