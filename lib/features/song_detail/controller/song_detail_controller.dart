import 'package:get/get.dart';
import '../../../core/models/song.dart';
import '../../../core/models/lyrics_block.dart';
import '../../../core/services/db_helper.dart';
import '../../home/controller/home_controller.dart';
import '../../favorites/controller/favorites_controller.dart';

class SongDetailController extends GetxController {
  final DbHelper _dbHelper = DbHelper.instance;

  final song = Rxn<Song>();
  final lyricsBlocks = <LyricsBlock>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final songId = Get.arguments as int;
    loadSong(songId);
  }

  Future<void> loadSong(int id) async {
    try {
      isLoading.value = true;
      final loadedSong = await _dbHelper.getSongById(id);
      song.value = loadedSong;
      
      // Load lyrics blocks
      if (loadedSong != null) {
        final blocks = await _dbHelper.getLyricsBlocks(id);
        lyricsBlocks.value = blocks;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load song: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (song.value == null) return;

    try {
      final newFavorite = !song.value!.favorite;
      await _dbHelper.toggleFavorite(song.value!.id, newFavorite);
      song.value = song.value!.copyWith(favorite: newFavorite);
      
      // Notify HomeController if it's active
      if (Get.isRegistered<HomeController>()) {
        final homeController = Get.find<HomeController>();
        final index = homeController.songs.indexWhere((s) => s.id == song.value!.id);
        if (index != -1) {
          homeController.songs[index] = song.value!;
          // Re-apply current filters
          if (homeController.selectedChar.value == 'All') {
            homeController.filteredSongs.value = homeController.songs;
          } else {
            homeController.filterByChar(homeController.selectedChar.value);
          }
        }
      }
      
      // Notify FavoritesController if it's active
      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>().loadFavoriteSongs(forceReload: true);
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to update favorite: $e';
      Get.snackbar('Error', errorMessage.value);
    }
  }
}

