import 'package:get/get.dart';

import '../controllers/view_note_controller.dart';

class ViewNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewNoteController>(
      () => ViewNoteController(),
    );
  }
}
