import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../data/models/folder.dart';
import '../../../global_widgets/circle_icon.dart';
import '../../home/controllers/home_controller.dart';

class CollapseItem extends GetView<HomeController> {
  final Folder folder;
  final Function() onTap;
  CollapseItem({required this.folder, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ObxValue<RxString>(
        (res) {
          return Stack(
            children: [
              Positioned.fill(
                left: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedSwitcher(
                    duration: 200.milliseconds,
                    child: res.value == folder.id
                        ? Icon(Icons.fiber_manual_record, size: 8)
                        : SizedBox(),
                  ),
                ),
              ),
              Positioned.fill(
                child: CircleIcon(
                  onTap: onTap,
                  icon: Icon(
                    EvaIcons.folder,
                    size: 22,
                    color: Colors.amber,
                  ),
                  tooltip: folder.name,
                  showToolTip: true,
                ),
              ),
            ],
          );
        },
        controller.currentFolderId,
      ),
    );
  }
}