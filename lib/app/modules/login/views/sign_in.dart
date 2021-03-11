import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/constraints/app_colors.dart';
import 'package:simple_note/app/modules/login/controllers/login_controller.dart';
import 'package:simple_note/app/modules/login/widgets/input_field.dart';

class SignInResponseView extends GetResponsiveView<LoginController> {
  SignInResponseView() : super(alwaysUseBuilder: false);
  @override
  Widget phone() => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Login", style: TextStyle(fontSize: 30)),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Username"),
                InputField(controller: controller.userNameCtrl, onSubmited: (value) {})
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Password"),
                InputField(
                  controller: controller.pwdCtrl,
                  obscureText: true,
                  onSubmited: (value) {},
                )
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
  @override
  Widget desktop() => Container(
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
                InputField(controller: controller.userNameCtrl, onSubmited: (value) {})
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
                  onSubmited: (value) {},
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
