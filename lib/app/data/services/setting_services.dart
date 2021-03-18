import 'package:hive/hive.dart';

import '../constraints/hive_box_name.dart';

class SettingServices {
  var settingBox = Hive.box(HiveBoxName.setting);

  bool get isOfflineMode => settingBox.get("offlineMode");

  void initSetting() {
    settingBox.put("offlineMode", false);
  }

  void setOfflineMode() {
    settingBox.put("offlineMode", true);
  }

  void setOnlineMode() {
    settingBox.put("offlineMode", false);
  }
}
