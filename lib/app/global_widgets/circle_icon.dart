import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final Color bgColor;
  final String tooltip;
  CircleIcon({@required this.onTap, @required this.icon, this.bgColor, @required this.tooltip});
  @override
  Widget build(BuildContext context) {
    final double iconSize = 30;
    return Material(
      color: Colors.transparent,
      child: _buildTooltip(
            context,
            InkWell(
              splashColor: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(1000),
              onTap: onTap,
              child: Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: bgColor,
                ),
                child: IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  child: icon,
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildTooltip(BuildContext context, Widget child) {
    return context.isPhone ? Tooltip(message: tooltip, child: child) : child;
  }
}
