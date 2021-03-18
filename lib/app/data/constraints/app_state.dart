import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/navigator_key_utils.dart';

class AppStates {
  Widget searchEmpty() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No Result"),
        ],
      ),
    );
  }

  Widget emptyNote() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Oops! There are no notes \nthat you have created",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            Get.toNamed(Routes.ADD_NOTE, id: NavigatorKeyUtils.leftSideNavigator);
          },
          icon: Icon(EvaIcons.plus),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(130, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          label: Text("Create Note"),
        )
      ],
    );
  }
}
