import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/constraints/app_colors.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/global_widgets/custom_app_bar.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetResponsiveView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: controller.scaffoldKey,
      appBar: CustomAppBar(
          childAlignment: MainAxisAlignment.start,
          childs: [SizedBox(width: 50), Text("Setting")],
          onTapBack: () => Get.back()),
      //endDrawer: EditProfileDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Wrap(
          runSpacing: 20,
          spacing: 20,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildAccountArea(controller.scaffoldKey),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildPrefrence(),
                SizedBox(height: 10),
                _buildSync(),
                SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSync() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Backup",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Save change to database",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          icon: Icon(EvaIcons.sync),
          onPressed: () {
            controller.backupData();
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                Size(100, 50),
              ),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(Colors.indigo)),
          label: Text("Backup now"),
        )
      ],
    );
  }

  Widget _buildPrefrence() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prefrence",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Change ratio between item area and view area will display",
          style: TextStyle(color: Colors.grey),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            onTap: () {},
            items: controller.ratios
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            value: controller.ratios.first,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Widget _buildAccountArea(GlobalKey<ScaffoldState> key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 100,
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.darkGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
            alignment: Alignment.center,
            child: ObxValue<Rx<User>>(
              (res) {
                final user = res.value;
                final avatarUrl = user.avatarUrl ;
                final displayName = user.name ?? "";
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        radius: 25,
                        child: avatarUrl == null
                            ? Container(
                                decoration: BoxDecoration(color: Colors.grey),
                              )
                            : Image.network(
                                avatarUrl,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(displayName,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                key.currentState.openEndDrawer();
                              },
                              child: Icon(EvaIcons.edit),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: RichText(
                              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                            TextSpan(text: "Not you? "),
                            TextSpan(text: " "),
                            TextSpan(
                                text: "Change user",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // log out
                                    controller.logOut();
                                  },
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ))
                          ])),
                        )
                      ],
                    )
                  ],
                );
              },
              controller.rxUser,
            ),
          ),
        ),
      ],
    );
  }
}
