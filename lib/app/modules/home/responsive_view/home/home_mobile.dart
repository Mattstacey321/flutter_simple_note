import 'package:flutter/material.dart';

import '../../../../global_widgets/custom_app_bar.dart';
import '../../navigators/left_side_navigator.dart';
import '../../widgets/home_menu.dart';

class HomeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [],
        menu: HomeMenu(),
      ),
      body: Center(
        child: LeftSideNavigator(),
      ),
    );
  }
}
