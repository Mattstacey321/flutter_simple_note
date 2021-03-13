import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/navigator_key_utils.dart';
import '../../add_note/views/add_note_view.dart';
import '../controllers/home_controller.dart';
import '../views/display_note_item.dart';

class LeftSideNavigator extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(NavigatorKeyUtils.leftSideNavigator),
        initialRoute: "/show-note",
        onGenerateRoute: (settings) {
          if (settings.name == "/show-note") {
            return GetPageRoute(routeName: "show-note", page: () => DisplayNoteItem());
          } else {
            return GetPageRoute(routeName: Routes.ADD_NOTE, page: () => AddNoteView());
          }
        },
      );
  }
  
}
