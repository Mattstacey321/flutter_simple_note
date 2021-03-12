import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_note/app/data/constraints/app_colors.dart';
import 'package:simple_note/app/data/models/note.dart';
import 'package:simple_note/app/utils/time_utils.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/global_widgets/circle_icon.dart';

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
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: AppColors.darkGrey.withOpacity(0.2)),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        content,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(TimeUtils().fullDate(createdAt))
                  ],
                ),
              ),
              Positioned(
                  right: 1,
                  child: AnimatedOpacity(
                      opacity: isHover ? 1 : 0,
                      duration: 200.milliseconds,
                      curve: Curves.ease,
                      child: CircleIcon(
                        icon: Icon(EvaIcons.close, color: Colors.white),
                        tooltip: "Remove",
                        onTap: widget.onRemove,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
