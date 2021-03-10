import 'package:flutter/material.dart';
import 'package:simple_note/app/data/constraints/app_colors.dart';
import 'package:simple_note/app/data/constraints/app_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline4: TextStyle(fontFamily: AppFonts.gSansRegular),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: AppColors.darkGrey,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.indigo,
    ),
    textTheme: TextTheme(
      headline4: TextStyle(fontFamily: AppFonts.gSansRegular),
    ),
  );
}
