import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'circle_icon.dart';

class CustomAppBar extends PreferredSize {
  final List<Widget> childs;
  final double height;
  final Widget homeIcon;
  final Widget menu;
  final VoidCallback onTapBack;
  final Color color;
  final Widget tabBar;
  final double childPadding;
  final MainAxisAlignment childAlignment;
  CustomAppBar(
      {@required this.childs,
      this.height = 50,
      this.menu = const SizedBox(),
      this.color = Colors.transparent,
      this.homeIcon: const Icon(Icons.chevron_left, size: 25),
      this.tabBar,
      this.childAlignment = MainAxisAlignment.center,
      this.childPadding = 20,
      this.onTapBack});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: childPadding),
      decoration: BoxDecoration(color: color, boxShadow: []),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              onTapBack == null ? const SizedBox() : const SizedBox(width: 40),
              Positioned(
                child: Container(
                  height: preferredSize.height,
                  child: Row(
                    mainAxisAlignment: childAlignment,
                    children: [
                      for (var widget in childs)
                        if (widget is Text)
                          DefaultTextStyle(
                              style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
                              child: widget)
                        else
                          widget
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  onTapBack == null
                      ? const SizedBox()
                      : CircleIcon(
                          tooltip: "Back",
                          onTap: () {
                            return onTapBack == null ? Get.back() : onTapBack();
                          },
                          icon: homeIcon),
                ],
              ),
              Positioned(right: 0, child: Container(child: menu))
            ],
          ),
          tabBar == null ? const SizedBox() : const SizedBox(height: 20),
          tabBar == null
              ? const SizedBox()
              : Container(
                  child: tabBar,
                ),
        ],
      ),
    );
  }
}