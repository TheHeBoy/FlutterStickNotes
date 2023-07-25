//Network global data
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash_stick_notes/app/data/database/sqlite_database.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/setting/logic.dart';

class AppConstants {
  AppConstants._();
  static late Directory directory;
  //存放文件图标的路径
  static const String _fileIconPath =  "\\fileIcon\\";

  static late ThemeMode _themeMode;
  static late bool _bootstrap;

  static init() async{
    directory = await getApplicationDocumentsDirectory();
    Directory iconDir = Directory(getFileIconPath());
    if (!await iconDir.exists()) {
      // 如果文件夹不存在，则创建文件夹及其所有上级目录
      await iconDir.create(recursive: true);
    }

    final db = Get.find<AppDataBase>();

    var setting = await db.getSettingById(SettingEnums.theme);
    _themeMode = ThemeMode.values.firstWhere((e) => e.name == setting.value);

    _bootstrap = bool.parse((await db.getSettingById(SettingEnums.bootstrap)).value);

    Get.log("项目路径为：${directory.path}");
  }

  static String getFileIconPath(){
    return directory.path + _fileIconPath;
  }

  static ThemeMode getThemeMode(){
    return _themeMode;
  }

  static bool getBootstrap(){
    return _bootstrap;
  }
}
