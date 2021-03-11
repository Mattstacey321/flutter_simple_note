import 'package:get/get.dart';
import 'package:simple_note/app/data/api/auth_provider.dart';
import 'package:simple_note/app/data/api/note_provider.dart';
import 'package:simple_note/app/data/services/auth_services.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthServices());
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => NoteProvider());
    Get.lazyPut<SettingController>(
      () => SettingController(
          authProvider: Get.find(), authServices: Get.find(), noteProvider: Get.find()),
    );
  }
}
