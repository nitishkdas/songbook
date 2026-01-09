import 'package:get/get.dart';
import '../controller/song_detail_controller.dart';

class SongDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongDetailController>(() => SongDetailController());
  }
}

