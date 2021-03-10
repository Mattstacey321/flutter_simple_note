import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/modules/add_note/views/add_note_view.dart';
import 'package:simple_note/app/modules/home/controllers/home_controller.dart';
import 'package:simple_note/app/modules/home/views/display_note_item.dart';
import 'package:simple_note/app/routes/app_pages.dart';

class LeftSideNavigator extends GetResponsiveView<HomeController> {
  LeftSideNavigator() : super(alwaysUseBuilder: false);
  @override
  Widget desktop() => Navigator(
        key: Get.nestedKey(1),
        initialRoute: "/show-note",
        onGenerateRoute: (settings) {
          if (settings.name == "/show-note") {
            return GetPageRoute(routeName: "show-note", page: () => DisplayNoteItem());
          } else {
            return GetPageRoute(routeName: Routes.ADD_NOTE, page: () => AddNoteView());
          }
        },
      );

  @override
  Widget phone() => Container();
}