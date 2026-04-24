import 'package:get/get.dart';
import '../../../core/models/song.dart';
import '../../../core/services/db_helper.dart';
import '../../../app/routes/app_routes.dart';

class SearchController extends GetxController {
  final DbHelper _dbHelper = DbHelper.instance;

  final searchQuery = ''.obs;
  final searchResults = <Song>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  void search(String query) {
    searchQuery.value = query;
    
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    _performSearch(query);
  }

  Future<void> _performSearch(String query) async {
    try {
      isLoading.value = true;
      final results = await _dbHelper.searchSongs(query);
      if (searchQuery.value == query) {
        searchResults.value = results;
      }
    } catch (e) {
      if (searchQuery.value == query) {
        hasError.value = true;
        errorMessage.value = 'Search failed: $e';
        Get.snackbar('Error', errorMessage.value);
      }
    } finally {
      if (searchQuery.value == query) {
        isLoading.value = false;
      }
    }
  }

  Future<void> navigateToSongDetail(int songId) async {
    await Get.toNamed(AppRoutes.songDetail, arguments: songId);
    // Refresh the song from database so any changes to favorites reflect when back
    final updatedSong = await _dbHelper.getSongById(songId);
    if (updatedSong != null) {
      final index = searchResults.indexWhere((s) => s.id == songId);
      if (index != -1) {
        searchResults[index] = updatedSong;
      }
    }
  }

  Future<void> toggleFavorite(Song song) async {
    try {
      await _dbHelper.toggleFavorite(song.id, !song.favorite);
      // Update local state
      final index = searchResults.indexWhere((s) => s.id == song.id);
      if (index != -1) {
        searchResults[index] = song.copyWith(favorite: !song.favorite);
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to update favorite: $e';
      Get.snackbar('Error', errorMessage.value);
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
  }
}

