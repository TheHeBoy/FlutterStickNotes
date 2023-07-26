import 'dart:convert';

import 'package:get/get.dart';
import 'package:flash_sticky_notes/app/data/database/sqlite_database.dart';
import 'package:flash_sticky_notes/features/setting/logic.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

class AppHotKey {
  static HotKeyAction? showWindowHotKeyAction;

  static void init() async {
    await hotKeyManager.unregisterAll();
    final db = Get.find<AppDataBase>();

    db.watchSetting(SettingEnums.showWindow).listen((data) {
      final hotKey = HotKey.fromJson(jsonDecode(data.value));
      if (showWindowHotKeyAction == null) {
        showWindowHotKeyAction = HotKeyAction(hotKey, (_) async {
          if (await windowManager.isVisible()) {
            windowManager.hide();
          } else {
            windowManager.show();
          }
        });
      } else {
        showWindowHotKeyAction!.update(hotKey);
      }
    });
  }
}

class HotKeyAction {
  HotKey _hotKey;

  final Function(HotKey hotKey) _action;

  HotKeyAction(this._hotKey, this._action) {
    hotKeyManager.register(_hotKey, keyDownHandler: _action);
  }

  void update(HotKey hotKey) {
    hotKeyManager.unregister(_hotKey);
    _hotKey = hotKey;
    hotKeyManager.register(hotKey, keyDownHandler: _action);
  }
}
