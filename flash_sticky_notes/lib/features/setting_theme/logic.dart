import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash_sticky_notes/app/data/database/sqlite_database.dart';
import 'package:flash_sticky_notes/features/setting/logic.dart';

class SettingThemeLogic extends GetxController {
  final db = Get.find<AppDataBase>();
  var themeGroup = Rx<ThemeMode?>(null);

  @override
  void onInit() {
    super.onInit();
    themeGroup.bindStream(db.watchSetting(SettingEnums.theme).map(
        (data) => ThemeMode.values.firstWhere((e) => e.name == data.value)));
  }

  void updateTheme(ThemeMode v) {
    Get.changeThemeMode(v);
    Future.delayed(const Duration(milliseconds: 250), () {
      Get.forceAppUpdate();
      db.updateSetting(Setting(key: SettingEnums.theme, value: v.name));
    });
  }
}
