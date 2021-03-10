import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/global_widgets/custom_app_bar.dart';
import 'package:simple_note/app/modules/login/controllers/sign_up_controller.dart';
import 'package:simple_note/app/modules/login/widgets/input_field.dart';

class SignUpResponseView extends GetResponsiveView<SignUpController> {
  final User user;
  SignUpResponseView({this.user}) : super(alwaysUseBuilder: false);

  @override
  Widget phone() {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [Text("Sign Up")],
        onTapBack: () => Get.back(id: 1),
      ),
    );
  }

  @override
  Widget desktop() {
    final userInfo = user;
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
                InputField(controller: controller.userNameCtrl, onSubmited: (value) {})
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
                  onSubmited: (value) {},
                )
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                controller.finishSignUp(userInfo.id);
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
