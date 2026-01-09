import 'package:get/get.dart';
import '../../features/home/controller/home_controller.dart';
import '../../features/favorites/controller/favorites_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Create permanent controllers that persist throughout app lifecycle
    // These will survive navigation but will be recreated on app restart
    // However, data will be pre-loaded for fast access
    if (!Get.isRegistered<HomeController>()) {
      Get.put<HomeController>(HomeController(), permanent: true);
    }
    if (!Get.isRegistered<FavoritesController>()) {
      Get.put<FavoritesController>(FavoritesController(), permanent: true);
    }
    
    // Pre-load data in background (non-blocking)
    // This loads from SQLite which persists on disk (handled by Android OS)
    _preloadData();
  }
  
  /// Pre-loads data asynchronously in the background
  /// This ensures data is ready when user navigates to home/favorites
  Future<void> _preloadData() async {
    // Load data asynchronously so app startup isn't blocked
    // Data will be ready when user navigates to these screens
    final homeController = Get.find<HomeController>();
    final favoritesController = Get.find<FavoritesController>();
    
    // Start loading both in parallel
    try {
      await Future.wait([
        homeController.loadSongs(),
        favoritesController.loadFavoriteSongs(),
      ]);
    } catch (error) {
      // Errors are already handled in controllers
      // Just catch here to prevent unhandled exceptions
    }
  }
}

