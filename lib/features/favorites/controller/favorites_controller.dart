import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../core/models/song.dart';
import '../../../core/services/db_helper.dart';
import '../../../app/routes/app_routes.dart';
import '../../home/controller/home_controller.dart';

class FavoritesController extends GetxController {
  final DbHelper _dbHelper = DbHelper.instance;

  final songs = <Song>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Only load if data is empty (caching)
    if (songs.isEmpty) {
      loadFavoriteSongs();
    }
  }

  Future<void> loadFavoriteSongs({bool forceReload = false}) async {
    // Skip if already loaded and not forcing reload
    if (!forceReload && songs.isNotEmpty && !isLoading.value) {
      debugPrint('[FavoritesController] Favorites already loaded, skipping...');
      return;
    }

    try {
      debugPrint('[FavoritesController] Loading favorite songs...');
      isLoading.value = true;
      final favoriteSongs = await _dbHelper.getFavoriteSongs();
      debugPrint('[FavoritesController] Loaded ${favoriteSongs.length} favorite songs');
      songs.value = favoriteSongs;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load favorites: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToSongDetail(int songId) {
    Get.toNamed(AppRoutes.songDetail, arguments: songId);
  }

  Future<void> toggleFavorite(Song song) async {
    try {
      await _dbHelper.toggleFavorite(song.id, !song.favorite);
      // Reload favorites to update the list (force reload)
      loadFavoriteSongs(forceReload: true);
      // Also update the home controller's state if it's active
      if (Get.isRegistered<HomeController>()) {
        final homeController = Get.find<HomeController>();
        // Update the song in home controller's list
        final index = homeController.songs.indexWhere((s) => s.id == song.id);
        if (index != -1) {
          homeController.songs[index] = song.copyWith(favorite: !song.favorite);
          // Re-apply filters
          homeController.filterByChar(homeController.selectedChar.value);
        }
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to update favorite: $e';
      Get.snackbar('Error', errorMessage.value);
    }
  }

  void navigateToHome() {
    Get.offNamed(AppRoutes.home);
  }
}

