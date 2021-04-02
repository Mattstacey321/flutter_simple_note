import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/loading_button.dart';
import '../controllers/view_note_controller.dart';

class UpdateButton extends GetView<ViewNoteController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>((res) {
      return AnimatedSwitcher(
        duration: 200.milliseconds,
        child: res.value
            ? LoadingButton(
                controller: controller.saveBtnCtrl,
                height: 60,
                width: 60,
                radius: 1000,
                onPressed: () {
                  controller.updateNote();
                },
                initialWidget: Icon(
                  EvaIcons.save,
                  color: Colors.white,
                ),
              )
            : SizedBox(),
      );
    }, controller.isAnyThingChange);
  }
}
