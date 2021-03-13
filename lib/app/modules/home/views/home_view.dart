import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/modules/home/responsive_view/home/home_desktop.dart';
import 'package:simple_note/app/modules/home/responsive_view/home/home_mobile.dart';

import '../../../global_widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_menu.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childAlignment: MainAxisAlignment.start,
        childs: [
          Text(
            "Home",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
        menu: HomeMenu(),
      ),
      body: Center(
        child: HomeReponseView(),
      ),
    );
  }
}

class HomeReponseView extends GetResponsiveView<HomeController> {
  HomeReponseView() : super(alwaysUseBuilder: false);
  @override
  Widget desktop() => HomeDesktop();

  @override
  Widget phone() => HomeMobile();
}
