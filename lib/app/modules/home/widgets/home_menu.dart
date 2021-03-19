import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../setting/controllers/setting_controller.dart';

class HomeMenu extends GetResponsiveView<SettingController> {
  HomeMenu() : super(alwaysUseBuilder: false);
  @override
  Widget desktop() {
    return Obx(
      () {
        final user = controller.rxUser.value;
        final avatarUrl = user?.avatarUrl;
        final offlineMode = controller.isOfflineMode.value;
        return Row(
          children: [
            Flexible(child: _buildAvatar(offlineMode: offlineMode, avatarUrl: avatarUrl)),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      user == null ? "" : user.name,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        size: 13,
                        color: offlineMode ? Colors.grey : Colors.green,
                      ),
                      offlineMode
                          ? Text(
                              "Offline",
                              style: TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              "Online",
                              style: TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            )
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget phone() {
    return Obx(() {
      final user = controller.rxUser.value;
      final avatarUrl = user?.avatarUrl;
      final offlineMode = controller.isOfflineMode.value;
      return Row(
        children: [
          Row(
            children: <Widget>[
              Icon(
                Icons.fiber_manual_record,
                color: offlineMode ? Colors.grey : Colors.green,
              ),
              offlineMode ? Text("Offline") : Text("Online")
            ],
          ),
          SizedBox(width: 10),
          _buildAvatar(avatarUrl: avatarUrl, offlineMode: offlineMode)
        ],
      );
    });
  }

  Widget _buildAvatar({bool offlineMode, String avatarUrl}) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SETTING);
      },
      borderRadius: BorderRadius.circular(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: offlineMode
            ? Container(
                height: 30,
                width: 30,
                color: Colors.grey,
              )
            : avatarUrl == null
                ? Container(
                    height: 30,
                    width: 30,
                    color: Colors.grey,
                  )
                : Image.network(
                    avatarUrl,
                    height: 30,
                    width: 30,
                    errorBuilder: (context, url, error) => Container(
                      color: Colors.grey,
                      height: 30,
                      width: 30,
                    ),
                  ),
      ),
    );
  }
}
