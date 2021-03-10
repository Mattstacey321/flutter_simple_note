import 'package:get/get.dart';

import 'package:simple_note/app/modules/add_note/bindings/add_note_binding.dart';
import 'package:simple_note/app/modules/add_note/views/add_note_view.dart';
import 'package:simple_note/app/modules/home/bindings/home_binding.dart';
import 'package:simple_note/app/modules/home/views/home_view.dart';
import 'package:simple_note/app/modules/login/bindings/login_binding.dart';
import 'package:simple_note/app/modules/login/views/login_view.dart';
import 'package:simple_note/app/modules/setting/bindings/setting_binding.dart';
import 'package:simple_note/app/modules/setting/views/setting_view.dart';
import 'package:simple_note/app/modules/view_note/bindings/view_note_binding.dart';
import 'package:simple_note/app/modules/view_note/views/view_note_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NOTE,
      page: () => AddNoteView(),
      binding: AddNoteBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_NOTE,
      page: () => ViewNoteItem(),
      binding: ViewNoteBinding(),
    ),
  ];
}
