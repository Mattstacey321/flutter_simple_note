import 'package:get/get.dart';

import '../../../data/api/auth_provider.dart';
import '../../../data/api/note_provider.dart';
import '../../../data/services/auth_services.dart';
import '../../../data/services/note_services.dart';
import '../../add_note/controllers/add_note_controller.dart';
import '../../setting/controllers/setting_controller.dart';
import '../../view_note/controllers/view_note_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteProvider());
    Get.lazyPut(() => NoteServices());
    Get.lazyPut<HomeController>(
      () => HomeController(
        noteProvider: Get.find(),
        noteServices: Get.find(),
      ),
    );
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => AuthServices());
    Get.lazyPut(
      () => SettingController(
          authProvider: Get.find(), authServices: Get.find(), noteProvider: Get.find()),
    );
    Get.lazyPut(() => AddNoteController(noteServices: Get.find(),noteProvider: Get.find()));
    Get.lazyPut(() => ViewNoteController(noteServices: Get.find(), noteProvider: Get.find()));
  }
}
