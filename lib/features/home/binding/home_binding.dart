import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Controller is already created in InitialBinding as permanent
    // Just ensure it exists (should already be registered)
    if (!Get.isRegistered<HomeController>()) {
      Get.put<HomeController>(HomeController(), permanent: true);
    }
  }
}

