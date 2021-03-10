import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_note/app/data/constraints/app_colors.dart';
import 'package:simple_note/app/data/models/note.dart';

class NoteItem extends StatelessWidget {
  final Note item;
  final Function onTap;
  NoteItem({@required this.item, this.onTap});
  @override
  Widget build(BuildContext context) {
    final title = item.title;
    final content = item.content;
    final createdTime = item.createdTime;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: AppColors.darkGrey.withOpacity(0.2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                content,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Text(createdTime.toString())
            ],
          ),
        ),
      ),
    );
  }
}