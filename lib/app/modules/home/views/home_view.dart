import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/global_widgets/custom_app_bar.dart';
import 'package:simple_note/app/modules/home/navigators/left_side_navigator.dart';
import 'package:simple_note/app/modules/home/widgets/home_menu.dart';
import 'package:simple_note/app/modules/view_note/views/view_note_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childAlignment: MainAxisAlignment.start,
        childs: [Text("Home")],
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
  Widget desktop() => Obx(
        () => Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: controller.viewItemSpace.value,
                child: LeftSideNavigator(),
              ),
              Listener(
                child: MouseRegion(
                    cursor: SystemMouseCursors.move,
                    child: VerticalDivider(indent: 20, endIndent: 20)),
              ),
              Expanded(
                flex: controller.viewNoteSpace.value,
                child: ViewNoteItem(),
              )
            ],
          ),
        ),
      );

  @override
  Widget phone() => Container();
}
