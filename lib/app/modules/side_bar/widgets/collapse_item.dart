import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../data/models/folder.dart';
import '../../../global_widgets/circle_icon.dart';

class CollapseItem extends StatelessWidget {
  final Folder folder;
  final Function onTap;
  CollapseItem({@required this.folder, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return CircleIcon(
      onTap: onTap,
      icon: Icon(
        EvaIcons.folder,
        size: 22,
        color: Colors.amber,
      ),
      tooltip: folder.name,
      showToolTip: true,
    );
  }
}
