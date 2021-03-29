import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../db/local_db.dart';
import 'setting_services.dart';

Future initServices() async {
  await Get.putAsync(() => DbServices().initHive());
}

Future initSreenSize() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // setWindowMinSize(Size(720, 720));
    // setWindowMaxSize(Size.infinite);
  }
}

class DbServices extends GetxService {
  Future<DbServices> initHive() async {
    Directory directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);
    // init config
    await LocalDb.init();
    SettingServices().initSetting();
    return this;
  }
}
