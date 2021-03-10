import 'package:flutter/material.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/modules/login/controllers/sign_up_controller.dart';
import 'package:simple_note/app/routes/app_pages.dart';
import 'package:simple_note/app/utils/keyboard_shortcut.dart';

class DialogsUtil {
  Future enterCode() async {
    final controller = Get.find<LoginController>();
    var codeCtrl = TextEditingController();

    return Get.generalDialog(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FocusableActionDetector(
          shortcuts: {escapeKeySet: CloseDialogIntent()},
          actions: {CloseDialogIntent: CallbackAction(onInvoke: (e) => Get.back())},
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: 1.seconds,
                height: 150,
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                          CurvedAnimation(
                              parent: animation,
                              curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Enter code"),
                          SizedBox(height: 15),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: codeCtrl,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration.collapsed(hintText: "Paste here"),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Get.back(closeOverlays: true);
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Get.dialog(
                                    Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.2,
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    ),
                                  );
                                  final authReponse =
                                      await controller.authWithGithub(codeCtrl.text);
                                  final user = authReponse.user;
                                  // created user
                                  if (authReponse.status == 201) {
                                    //auth succcss
                                    // offall to home

                                    Get.back(closeOverlays: true);
                                    Get.toNamed(Routes.SIGNUP, id: 1, arguments: authReponse.user);
                                  } else if (authReponse.status == 200) {
                                    Get.back(closeOverlays: true);
                                    /*Get.showSnackbar(GetBar(
                                      duration: 3.seconds,
                                      message: "Welcome back, ",
                                    ));*/
                                    AuthServices().setLogin(user);
                                    
                                    Get.offNamedUntil(Routes.HOME, (route) => !Get.isDialogOpen);
                                  } else {
                                    Get.back();
                                    Get.showSnackbar(GetBar(
                                      duration: 3.seconds,
                                      message: "Error during sign up",
                                    ));
                                  }
                                },
                                child: Text("Verify"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.translate(
          offset: Offset(animation.value, animation.value * 15),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      barrierDismissible: false,
      barrierLabel: "Save as draft",
    );
  }

  Future cancelSignUp() async {
    return Get.generalDialog(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FocusableActionDetector(
          shortcuts: {escapeKeySet: CloseDialogIntent()},
          actions: {CloseDialogIntent: CallbackAction(onInvoke: (e) => Get.back())},
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: 1.seconds,
                height: 100,
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                          CurvedAnimation(
                              parent: animation,
                              curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Confirm Exit ?"),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Get.back(id: 1);
                                  Get.back();
                                  SignUpController.to.clearData();
                                },
                                child: Text("Back to login"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.translate(
          offset: Offset(animation.value, animation.value * 15),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      barrierDismissible: false,
      barrierLabel: "Save as draft",
    );
  }

  Future logOutDialog({Function onLogOut}) async {
    return Get.generalDialog(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FocusableActionDetector(
          shortcuts: {escapeKeySet: CloseDialogIntent()},
          actions: {CloseDialogIntent: CallbackAction(onInvoke: (e) => Get.back())},
          child: Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: 1.seconds,
                height: 120,
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(
                      parent: animation, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Log out ?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: onLogOut,
                            style: TextButton.styleFrom(
                                primary: Colors.white, backgroundColor: Colors.red),
                            child: Text("OK"),
                          ),
                          /*ElevatedButton(
                            onPressed: () => onLogOut,
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  Size(100, 45),
                                ),
                                alignment: Alignment.center,
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                                backgroundColor: MaterialStateProperty.all(Colors.red)),
                            child: Text("Log out"),
                          ),*/
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.translate(
          offset: Offset(animation.value, animation.value * 15),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      barrierDismissible: false,
      barrierLabel: "Save as draft",
    );
  }
}
