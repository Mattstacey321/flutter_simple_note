import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../data/constraints/app_colors.dart';
import '../../../data/models/note.dart';
import '../../../global_widgets/circle_icon.dart';
import '../../../utils/time_utils.dart';

class NoteItem extends StatefulWidget {
  final Note item;
  final Function onTap;
  final Function onRemove;
  NoteItem({@required this.item, this.onTap, this.onRemove});

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool isHover = false;
  bool isLeave = false;
  @override
  Widget build(BuildContext context) {
    final title = widget.item.title;
    final content = widget.item.content;
    final createdAt = widget.item.createdAt;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        if (event.localDelta.dx.abs() <= 4) {
          setState(() {
            isHover = true;
          });
        }
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: widget.onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.darkGrey.withOpacity(0.25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: AutoSizeText(
                        content,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: AutoSizeText(
                          TimeUtils().fullDate(createdAt),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: AnimatedOpacity(
                opacity: isHover ? 1 : 0,
                duration: 200.milliseconds,
                curve: Curves.ease,
                child: CircleIcon(
                  icon: Icon(
                    EvaIcons.close,
                    color: Colors.white,
                    size: 15,
                  ),
                  tooltip: "Remove",
                  onTap: widget.onRemove,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
