import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/services/db_helper.dart';

class SongbookSelectionController extends GetxController {
  final DbHelper _dbHelper = DbHelper.instance;

  final songCount = 0.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadSongCount();
  }

  Future<void> loadSongCount() async {
    try {
      isLoading.value = true;
      final count = await _dbHelper.getSongCount();
      songCount.value = count;
    } catch (e) {
      // Set default count if error occurs
      songCount.value = 0;
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToHome() {
    Get.toNamed(AppRoutes.home);
  }

  void showComingSoon() {
    Get.snackbar(
      'Coming Soon',
      'This songbook will be available soon. Stay tuned!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
