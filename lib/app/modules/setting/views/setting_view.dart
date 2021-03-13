import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';
import '../responsive_view/setting_desktop.dart';
import '../responsive_view/setting_mobile.dart';

class SettingView extends GetResponsiveView<SettingController> {
  SettingView() : super(alwaysUseBuilder: false);

  @override
  Widget phone() =>  SettingMobile();

  @override
  Widget desktop() => SettingDesktop();
}
