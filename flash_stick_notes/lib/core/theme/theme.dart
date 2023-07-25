import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/data/database/sqlite_database.dart';
import '../../features/setting/logic.dart';

class AppTheme{
  final db = Get.find<AppDataBase>();
}

class AppLightTheme {
  static const _kPrimaryColor = Color(0xff416ff4);
  static const _kSecondaryColor = Color(0xff008D94);
  static const _kDefaultTextColor = Color(0xff000000);
  static const _kScaffoldBackgroundColor = Color(0xfff2f3f5);
  static const _kCanvasColor = Colors.white;

  static const _kDefaultTextStyle = TextStyle(
    color: _kDefaultTextColor,
    fontFamily: 'NotoSansSC',
  );
  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _kPrimaryColor,
      primary: _kPrimaryColor,
      secondary: _kSecondaryColor,
    ),
    primaryColor: _kPrimaryColor,
    canvasColor: _kCanvasColor,
    scaffoldBackgroundColor: _kScaffoldBackgroundColor,
    dividerColor: Colors.grey.withOpacity(0.2),
    dialogBackgroundColor: _kCanvasColor,
    fontFamily: 'NotoSansSC',
    textTheme: TextTheme(
      titleLarge: _kDefaultTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: _kDefaultTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: _kDefaultTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _kDefaultTextStyle.copyWith(
        fontSize: 16,
      ),
      bodyMedium: _kDefaultTextStyle.copyWith(
        fontSize: 14,
      ),
      bodySmall: _kDefaultTextStyle.copyWith(
        color: _kDefaultTextColor.withOpacity(0.5),
        fontSize: 12,
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: _kCanvasColor,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
        opacity: 1,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
        opacity: 1,
        size: 24,
      ),
      titleTextStyle: _kDefaultTextStyle.copyWith(
        fontSize: 15,
      ),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: _kPrimaryColor,
      barBackgroundColor: _kCanvasColor,
    ),
  );

  static Color getColor() {
    return _kScaffoldBackgroundColor;
  }
}

class AppDarkTheme {
  static const _kDefaultTextColor = Colors.white;

  static const _kPrimaryColor = Color(0xff416ff4);
  static const _kSecondaryColor = Color(0xff008D94);
  static const _kCanvasColor = Color(0xff282828);
  static const _kScaffoldBackgroundColor = Color(0xff1d1d1d);
  static const _kDefaultTextStyle = TextStyle(
    color: _kDefaultTextColor,
    fontFamily: 'NotoSansSC',
  );

  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _kPrimaryColor,
      primary: _kPrimaryColor,
      secondary: _kSecondaryColor,
    ),
    primaryColor: _kPrimaryColor,
    canvasColor: _kCanvasColor,
    scaffoldBackgroundColor: _kScaffoldBackgroundColor,
    dialogBackgroundColor: _kCanvasColor,
    fontFamily: 'NotoSansSC',
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: _kDefaultTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: _kDefaultTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: _kDefaultTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: _kDefaultTextStyle.copyWith(
        fontSize: 16,
      ),
      bodyMedium: _kDefaultTextStyle.copyWith(
        fontSize: 14,
      ),
      bodySmall: _kDefaultTextStyle.copyWith(
        color: _kDefaultTextColor.withOpacity(0.5),
        fontSize: 12,
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: _kCanvasColor,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
        opacity: 1,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        opacity: 1,
        size: 24,
      ),
      titleTextStyle: _kDefaultTextStyle.copyWith(
        fontSize: 15,
      ),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: _kPrimaryColor,
      barBackgroundColor: _kCanvasColor,
      textTheme: CupertinoTextThemeData(
        textStyle: _kDefaultTextStyle.copyWith(),
      ),
    ),
  );

  static Color getColor() {
    return _kScaffoldBackgroundColor;
  }
}
