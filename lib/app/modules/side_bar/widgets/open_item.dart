import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../data/models/folder.dart';
import '../../home/controllers/home_controller.dart';

class OpenItem extends GetView<HomeController> {
  final Folder folder;
  final bool isSelected;
  final int total;
  final Function onTap;
  final Function onEdit;
  final Function onRemove;
  OpenItem({
    @required this.folder,
    this.total = 0,
    this.isSelected = false,
    @required this.onTap,
    @required this.onEdit,
    @required this.onRemove,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onSecondaryTapDown: (details) {
        // right click context menu
        _buildContextMenu(context, details.globalPosition);
      },
      behavior: HitTestBehavior.translucent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
            height: 30,
            child: ObxValue<RxString>(
              (res) {
                return Stack(
                  children: [
                    Positioned.fill(
                      left: 0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedSwitcher(
                          duration: 200.milliseconds,
                          child: res.value == folder.id
                              ? VerticalDivider(
                                  thickness: 3,
                                  width: 3,
                                  color: Colors.white,
                                )
                              : SizedBox(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      left: 20,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            EvaIcons.folder,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 10),
                          Text(folder.name),
                          Spacer(),
                          Text("$total")
                        ],
                      ),
                    )
                  ],
                );
              },
              controller.currentFolderId,
            )),
      ),
    );
  }

  void _buildContextMenu(BuildContext context, Offset offset) {
    BotToast.showAttachedWidget(
      target: offset,
      preferDirection: PreferDirection.rightTop,
      attachedBuilder: (cancelFunc) {
        return Material(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 100,
            width: 200,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Icon(EvaIcons.edit),
                        SizedBox(width: 10),
                        Text("Edit"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Icon(EvaIcons.trash2),
                        SizedBox(width: 10),
                        Text("Remove")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
