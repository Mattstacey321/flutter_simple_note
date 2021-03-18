import 'package:get/get.dart';

import '../../../data/api/auth_provider.dart';
import '../../../data/api/folder_provider.dart';
import '../../../data/api/note_provider.dart';
import '../../../data/services/auth_services.dart';
import '../../../data/services/folder_services.dart';
import '../../../data/services/note_services.dart';
import '../../../data/services/setting_services.dart';
import '../../setting/controllers/setting_controller.dart';
import '../../side_bar/controllers/side_bar_controller.dart';
import '../../view_note/controllers/view_note_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoteProvider());
    Get.lazyPut(() => NoteServices());
    Get.lazyPut(() => FolderServices());
    Get.lazyPut(() => FolderProvider());
    Get.lazyPut<SideBarController>(
      () => SideBarController(
        noteServices: Get.find(),
        folderProvider: Get.find(),
        folderServices: Get.find()
      ),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        noteProvider: Get.find(),
        noteServices: Get.find(),
      ),
    );
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => AuthServices());
    Get.lazyPut(() => SettingServices());
    Get.lazyPut(
      () => SettingController(
        authProvider: Get.find(),
        authServices: Get.find(),
        noteProvider: Get.find(),
        settingService: Get.find(),
      ),
    );
    //Get.lazyPut(() => AddNoteController(noteServices: Get.find(), noteProvider: Get.find()));
    Get.lazyPut(() => ViewNoteController(noteServices: Get.find(), noteProvider: Get.find()));
  }
}
