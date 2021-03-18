import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../data/models/note.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/navigator_key_utils.dart';
import '../controllers/home_controller.dart';

class AddNoteButton extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue<RxList<Note>>(
      (res) {
        return AnimatedSwitcher(
          duration: 200.milliseconds,
          child: res.isEmpty
              ? SizedBox()
              : FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(
                      Routes.ADD_NOTE,
                      id: NavigatorKeyUtils.leftSideNavigator,
                    );
                  },
                  child: Icon(EvaIcons.plus, color: Colors.white),
                ),
        );
      },
      controller.notes,
    );
  }
}
