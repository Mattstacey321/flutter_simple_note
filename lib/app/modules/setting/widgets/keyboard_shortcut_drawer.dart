import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_app_bar.dart';

class KeyboardShortcutDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: CustomAppBar(
          childs: [Text("Shortcut")],
          onTapBack: () => Get.back(),
        ),
        body: Container(
          height: Get.height,
          
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
             
            ],
          ),
        ),
      ),
    );
  }
}