import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_note/app/data/models/user.dart';
import 'package:simple_note/app/modules/setting/controllers/setting_controller.dart';
import 'package:simple_note/app/routes/app_pages.dart';

class HomeMenu extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<User>>(
      (res) {
        final user = res.value;
        final avatarUrl = user?.avatarUrl;
        return Row(
          children: [
            Row(
              children: <Widget>[
                Icon(
                  Icons.fiber_manual_record,
                  color: Colors.green,
                ),
                Text("Online")
              ],
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.SETTING);
              },
              borderRadius: BorderRadius.circular(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: avatarUrl == null
                    ? Container(
                        height: 30,
                        width: 30,
                        color: Colors.grey,
                      )
                    : Container(
                        child: Image.network(
                          user.avatarUrl,
                          height: 30,
                          width: 30,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        );
      },
      controller.rxUser,
    );
  }
}
