import 'dart:io';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayMenu {
  TrayMenu._();

  static void init() async {
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/images/logo.ico' : 'assets/images/logo.png',
    );

    Menu menu = Menu(
      items: [
        MenuItem(
            key: 'show_window',
            label: 'Show Window',
            onClick: (_) => windowManager.show()),
        MenuItem(
            key: 'hide_window',
            label: 'Hide window',
            onClick: (_) => windowManager.hide()),
        MenuItem.separator(),
        MenuItem(
            key: 'exit_app',
            label: 'Exit App',
            onClick: (_) => windowManager.close()),
      ],
    );

    await trayManager.setContextMenu(menu);
    trayManager.addListener(AppTrayListener());
  }
}

class AppTrayListener extends TrayListener {
  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }
}
