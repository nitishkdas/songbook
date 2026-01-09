import 'package:get/get.dart';
import '../controller/songbook_selection_controller.dart';

class SongbookSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongbookSelectionController>(() => SongbookSelectionController());
  }
}

