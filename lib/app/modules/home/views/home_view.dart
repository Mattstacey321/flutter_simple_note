import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../responsive_view/home/home_desktop.dart';
import '../responsive_view/home/home_mobile.dart';

class HomeReponseView extends GetResponsiveView<HomeController> {
  HomeReponseView() : super(alwaysUseBuilder: false);
  @override
  Widget desktop() => HomeDesktop();

  @override
  Widget phone() => HomeMobile();
}
