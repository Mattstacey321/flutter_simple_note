import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../data/constraints/app_colors.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/input_field.dart';

class SignInDesktop extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Username"),
              SizedBox(height: 10),
              InputField(
                controller: controller.userNameCtrl,
                hintText: "",
                onSubmited: (value) {},
                onChanged: (value) {},
              )
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Password"),
              SizedBox(height: 10),
              InputField(
                controller: controller.pwdCtrl,
                obscureText: true,
                hintText: "",
                onSubmited: (value) {}, onChanged: (value) {},
              ),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              controller.logIn();
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(200, 50),
                ),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all(Colors.indigo)),
            child: Text("Login"),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("Or")],
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            icon: Icon(EvaIcons.github),
            label: Text("Login with Github"),
            onPressed: () {
              controller.requestGithubCode();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                Size(200, 50),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                AppColors.darkGrey.withOpacity(0.2),
              ),
            ),
          )
        ],
      ),
    );
  }
}
