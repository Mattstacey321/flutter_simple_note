import 'package:get/get.dart';

class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
   /* Get.lazyPut(() => NoteProvider());
    Get.lazyPut(() => NoteServices());
    Get.lazyPut<AddNoteController>(
      () => AddNoteController(noteProvider: Get.find(), noteServices: Get.find()),
    );*/
  }
}
