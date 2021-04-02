import 'package:flutter/material.dart';
import 'package:simple_note/app/data/constraints/app_styles.dart';

import '../../../../global_widgets/custom_app_bar.dart';
import '../../navigators/left_side_navigator.dart';
import '../../widgets/home_menu.dart';

class HomeMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childAlignment: MainAxisAlignment.start,
        childPadding: 20,
        childs: [
          Text(
            "Notes",
            style: AppStyles.appBarTitle,
          )
        ],
        menu: HomeMenu(),
      ),
      body: Center(
        child: LeftSideNavigator(),
      ),
    );
  }
}
