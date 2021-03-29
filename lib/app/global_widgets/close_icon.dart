import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CloseIcon extends StatefulWidget {
  final Function() onTap;
  CloseIcon({required this.onTap});
  @override
  _CloseIconState createState() => _CloseIconState();
}

class _CloseIconState extends State<CloseIcon> {
  bool isEnter = false;

  void onEnter() {
    setState(() {
      isEnter = true;
    });
  }

  void onExit() {
    setState(() {
      isEnter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onEnter(),
      onExit: (event) => onExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Icon(
          Icons.close,
          color: isEnter ? Colors.grey : Colors.grey[350],
          size: 20,
        ),
      ),
    );
  }
}