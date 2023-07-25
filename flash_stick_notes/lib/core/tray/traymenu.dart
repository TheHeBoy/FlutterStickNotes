import 'dart:io';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../window/windowmanage.dart';

class TrayMenu{
  TrayMenu._();

  static void init() async{
    await trayManager.setIcon(
      Platform.isWindows
          ? 'assets/images/goal.ico'
          : 'assets/images/goal.png',
    );

    Menu menu = Menu(
      items: [
        MenuItem(
          key: 'show_window',
          label: 'Show Window',
          onClick: (_) => windowManager.show()
        ),
        MenuItem(
          key: 'hide_window',
          label: 'Hide window',
          onClick: (_) => windowManager.hide()
        ),
        MenuItem.separator(),
        MenuItem(
            key: 'exit_app',
            label: 'Exit App',
            onClick: (_) =>windowManager.close()
        ),
      ],
    );

    await trayManager.setContextMenu(menu);
    trayManager.addListener(AppTrayListener());
  }
}

class AppTrayListener extends TrayListener{

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }
}