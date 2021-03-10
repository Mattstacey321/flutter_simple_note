import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/global_widgets/custom_app_bar.dart';

class EditProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: CustomAppBar(
          childs: [Text("Profile Detail")],
          onTapBack: () => Get.back(),
        ),
        body: Container(
          height: Get.height,
          
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
    );
  }
}
