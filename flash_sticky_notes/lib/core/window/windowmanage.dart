import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppWindow {
  AppWindow._();

  static void init() async {
    // Must add this line.
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        windowButtonVisibility: false,
        size: Size(350, 350),
        minimumSize: Size(200, 200),
        backgroundColor: Colors.transparent,
        skipTaskbar: true,
        titleBarStyle: TitleBarStyle.hidden,
        alwaysOnTop: true);

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // await windowManager.maximize();
      await windowManager.setAlignment(Alignment.topRight);
      // await windowManager.setAlwaysOnBottom(true);
      await windowManager.show();
      // await windowManager.focus();
    });

    windowManager.addListener(_Listener());
  }
}

class _Listener with WindowListener {
  @override
  void onWindowEvent(String eventName) {}

  @override
  void onWindowClose() {}

  @override
  void onWindowFocus() {
    // final logic = Get.find<StickyNoteLogic>();
    // logic.setIsAppBarVisible(true);
  }

  @override
  void onWindowBlur() {
    // final logic = Get.find<StickyNoteLogic>();
    // logic.setIsAppBarVisible(false);
  }

  @override
  void onWindowMaximize() {
    // do something
  }

  @override
  void onWindowUnmaximize() {
    // do something
  }

  @override
  void onWindowMinimize() {
    // do something
  }

  @override
  void onWindowRestore() {
    // do something
  }

  @override
  void onWindowResize() {}

  @override
  void onWindowMove() {
    // do something
  }

  @override
  void onWindowEnterFullScreen() {
    // do something
  }

  @override
  void onWindowLeaveFullScreen() {
    // do something
  }
}
