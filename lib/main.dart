import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_note/app/data/constraints/app_theme.dart';
import 'package:simple_note/app/data/services/auth_services.dart';
import 'package:simple_note/app/data/services/db_services.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSreenSize();
  await initServices();
  AuthServices _authSerivce = AuthServices();

  runApp(
    GetMaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: _authSerivce.isLogin ? Routes.HOME : Routes.LOGIN,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      getPages: AppPages.routes,
    ),
  );
}
