import 'package:get/get.dart';
import 'package:simple_note/app/modules/add_note/controllers/add_note_controller.dart';
import 'package:simple_note/app/modules/setting/controllers/setting_controller.dart';
import 'package:simple_note/app/modules/view_note/controllers/view_note_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => AddNoteController());
    Get.lazyPut(() => ViewNoteController());
  }
}
