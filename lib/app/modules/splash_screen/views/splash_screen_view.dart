import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_note/app/global_widgets/circle_icon.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ObxValue<Rx<ServerStatus>>(
        (res) {
          final serverStatus = res.value;
          return serverStatus == ServerStatus.checking
              ? _buildCheckingServer()
              : serverStatus == ServerStatus.offline
                  ? _buildOfflineNotify()
                  : SizedBox();
        },
        controller.serverStatus,
      )),
    );
  }

  Widget _buildCheckingServer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ),
        SizedBox(height: 15),
        Text("Check server..."),
      ],
    );
  }

  Widget _buildOfflineNotify() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleIcon(
            onTap: () {
              controller.reCheck();
            },
            icon: Icon(EvaIcons.refresh),
            tooltip: "Re-check",
          ),
          SizedBox(height: 15),
          Text("Offline")
        ],
      ),
    );
  }
}
