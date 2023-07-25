import 'dart:convert';

import 'package:get/get.dart';
import 'package:flash_stick_notes/app/data/database/sqlite_database.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class SettingLogic extends GetxController {
  var showWindow = Rx<HotKey?>(null);
  var settingsMap = <SettingEnums, String>{}.obs;
  final db = Get.find<AppDataBase>();

  @override
  void onInit() {
    super.onInit();
    showWindow.bindStream(db
        .watchSetting(SettingEnums.showWindow)
        .map((data) => HotKey.fromJson(jsonDecode(data.value))));

    settingsMap.bindStream(db.watchSettings().map((data) {
      final dataMap = <SettingEnums, String>{};
      for (var d in data) {
        dataMap[d.key] = d.value;
      }
      return dataMap;
    }));
  }

  void updateSetting(SettingEnums settingEnum, String value) {
    db.updateSetting(Setting(key: settingEnum, value: value));
  }
}

enum SettingEnums {
  showToolbar,
  showWindow,
  theme,
  bootstrap
}
