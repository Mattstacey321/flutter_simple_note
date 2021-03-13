import 'package:hive/hive.dart';

import '../constraints/hive_box_name.dart';

class SettingServices {
  var settingBox = Hive.openBox(HiveBoxName.setting);
}
