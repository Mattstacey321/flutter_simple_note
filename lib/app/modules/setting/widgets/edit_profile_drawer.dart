import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_app_bar.dart';

class EditProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width * 0.3,
      child: Drawer(
        child: Scaffold(
          appBar: CustomAppBar(
            childs: [
              Text(
                "Profile Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
            onTapBack: () => Get.back(),
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Spacer(),
                ElevatedButton.icon(
                  icon: Icon(EvaIcons.save),
                  onPressed: () {},
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width, 50),
                      ),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo)),
                  label: Text("Update"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
