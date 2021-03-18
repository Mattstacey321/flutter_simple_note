import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../side_bar/views/side_bar.dart';
import '../../../view_note/views/view_note_view.dart';
import '../../controllers/home_controller.dart';
import '../../navigators/left_side_navigator.dart';

class HomeDesktop extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: controller.viewItemSpace.value,
              child: Row(
                children: <Widget>[
                  SideBar(),
                  Expanded(
                    flex: 2,
                    child: LeftSideNavigator(),
                  )
                ],
              ),
            ),
            Listener(
              child: MouseRegion(
                cursor: SystemMouseCursors.move,
                child: VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
              ),
            ),
            Expanded(
              flex: controller.viewNoteSpace.value,
              child: ViewNoteItem(),
            )
          ],
        ),
      ),
    );
  }
}
