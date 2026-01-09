import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../core/models/song.dart';
import '../../../core/services/db_helper.dart';
import '../../../app/routes/app_routes.dart';
import '../../favorites/controller/favorites_controller.dart';

class HomeController extends GetxController {
  final DbHelper _dbHelper = DbHelper.instance;

  final songs = <Song>[].obs;
  final filteredSongs = <Song>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final selectedChar = 'All'.obs;
  final searchQuery = ''.obs;
  final allChars = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Only load if data is empty (caching)
    if (songs.isEmpty) {
      loadSongs();
    }
    if (allChars.isEmpty) {
      loadChars();
    }
  }

  Future<void> loadSongs({bool forceReload = false}) async {
    // Skip if already loaded and not forcing reload
    if (!forceReload && songs.isNotEmpty) {
      debugPrint('[HomeController] Songs already loaded, skipping...');
      return;
    }

    try {
      debugPrint('[HomeController] Loading songs...');
      isLoading.value = true;
      final allSongs = await _dbHelper.getAllSongs();
      debugPrint('[HomeController] Loaded ${allSongs.length} songs');
      songs.value = allSongs;
      filteredSongs.value = allSongs;
      debugPrint('[HomeController] Songs loaded successfully');
    } catch (e, stackTrace) {
      debugPrint('[HomeController] Error loading songs: $e');
      debugPrint('[HomeController] Stack trace: $stackTrace');
      hasError.value = true;
      errorMessage.value = 'Failed to load songs: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadChars({bool forceReload = false}) async {
    // Skip if already loaded and not forcing reload
    if (!forceReload && allChars.isNotEmpty) {
      debugPrint('[HomeController] Characters already loaded, skipping...');
      return;
    }

    try {
      debugPrint('[HomeController] Loading characters...');
      final chars = await _dbHelper.getAllChars();
      debugPrint('[HomeController] Loaded ${chars.length} characters: $chars');
      allChars.value = chars;
    } catch (e, stackTrace) {
      debugPrint('[HomeController] Error loading characters: $e');
      debugPrint('[HomeController] Stack trace: $stackTrace');
    }
  }

  void filterByChar(String char) {
    selectedChar.value = char;
    if (char == 'All') {
      filteredSongs.value = songs;
    } else {
      final filtered = songs.where((song) => song.char.toLowerCase() == char.toLowerCase()).toList();
      filteredSongs.value = filtered;
    }
  }

  void search(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filterByChar(selectedChar.value);
      return;
    }

    // Check if query is a number (for ID search)
    final isNumeric = int.tryParse(query.trim()) != null;
    final queryLower = query.toLowerCase();

    final results = songs.where((song) {
      // Search by ID if query is numeric
      if (isNumeric) {
        final id = int.tryParse(query.trim());
        if (song.id == id) {
          return true;
        }
      }
      // Search in title and lyrics
      final titleMatch = song.songTitle.toLowerCase().contains(queryLower);
      final lyricMatch = song.lyric.toLowerCase().contains(queryLower);
      return titleMatch || lyricMatch;
    }).toList();

    filteredSongs.value = results;
  }

  void navigateToSongDetail(int songId) {
    Get.toNamed(AppRoutes.songDetail, arguments: songId);
  }

  void navigateToFavorites() {
    Get.toNamed(AppRoutes.favorites);
  }

  void navigateToSearch() {
    Get.toNamed(AppRoutes.search);
  }

  void navigateToSongbookSelection() {
    Get.offAllNamed(AppRoutes.songbookSelection);
  }

  Future<void> toggleFavorite(Song song) async {
    try {
      await _dbHelper.toggleFavorite(song.id, !song.favorite);
      // Update local state
      final index = songs.indexWhere((s) => s.id == song.id);
      if (index != -1) {
        songs[index] = song.copyWith(favorite: !song.favorite);
        // Re-apply current filters
        if (selectedChar.value == 'All') {
          filteredSongs.value = songs;
        } else {
          filterByChar(selectedChar.value);
        }
        // Update favorites controller if it's active
        if (Get.isRegistered<FavoritesController>()) {
          Get.find<FavoritesController>().loadFavoriteSongs(forceReload: true);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update favorite: $e');
    }
  }
}

