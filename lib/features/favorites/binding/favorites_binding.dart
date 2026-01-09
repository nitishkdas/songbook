import 'package:get/get.dart';
import '../controller/favorites_controller.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    // Controller is already created in InitialBinding as permanent
    // Just ensure it exists (should already be registered)
    if (!Get.isRegistered<FavoritesController>()) {
      Get.put<FavoritesController>(FavoritesController(), permanent: true);
    }
  }
}

