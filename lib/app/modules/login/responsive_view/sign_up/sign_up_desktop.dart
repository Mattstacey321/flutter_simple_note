import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../global_widgets/custom_app_bar.dart';
import '../../controllers/sign_up_controller.dart';
import '../../widgets/input_field.dart';

class SignUpDesktop extends GetView<SignUpController> {
  final int userId;
  SignUpDesktop({this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [Text("Sign Up")],
        onTapBack: () => controller.onCancelSignUp(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Username"),
                SizedBox(height: 10),
                InputField(
                  controller: controller.userNameCtrl,
                  hintText: "Username",
                  onSubmited: (value) {},
                  onChanged: (value) {},
                )
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Password"),
                SizedBox(height: 10),
                InputField(
                  controller: controller.passwordCtrl,
                  obscureText: true,
                  hintText: "Password",
                  onSubmited: (value) {},
                  onChanged: (value) {},
                )
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Retype"),
                SizedBox(height: 10),
                InputField(
                  controller: controller.passwordCtrl,
                  obscureText: true,
                  hintText: "Retype",
                  onSubmited: (value) {},
                  onChanged: (value) {},
                )
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.finishSignUp(userId);
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(200, 50),
                  ),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(Colors.indigo)),
              child: Text("Finish"),
            ),
          ],
        ),
      ),
    );
  }
}
