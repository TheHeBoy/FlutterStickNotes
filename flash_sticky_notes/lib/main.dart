import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash_sticky_notes/app/data/app_storage.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flash_sticky_notes/core/hotkey/hotkey.dart';
import 'package:flash_sticky_notes/core/resources/size_manager.dart';
import 'app/constants/app_constants.dart';
import 'app/data/database/sqlite_database.dart';
import 'app/routes/app_pages.dart';
import 'core/localization/local_keys.dart';
import 'core/localization/messages.dart';
import 'core/theme/theme.dart';
import 'core/tray/traymenu.dart';
import 'core/window/windowmanage.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //持久化初始化
  await AppStorage.init();
  await AppDataBase.init();
  //常量初始化：项目文件路径、默认设置等
  await AppConstants.init();

  //开机自启
  launchAtStartup.setup(
    appName: (await PackageInfo.fromPlatform()).appName,
    appPath: Platform.resolvedExecutable,
  );
  if(AppConstants.getBootstrap()){
    await launchAtStartup.enable();
  }


  //热键初始化
  AppHotKey.init();
  //窗口初始化
  AppWindow.init();
  //状态栏菜单初始化
  TrayMenu.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return GetMaterialApp(
      title: LocalKeys.appName.tr,
      debugShowCheckedModeBanner: false,
      themeMode: AppConstants.getThemeMode(),
      theme: AppLightTheme.themeData,
      darkTheme: AppDarkTheme.themeData,
      getPages: AppPages.routes,
      translations: Messages(),
      locale: Messages.locale,
      fallbackLocale: Messages.fallbackLocale,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        child = Stack(
          children: [
            ClipRRect(
              child: child,
            ),
            const DragToMoveArea(
              child: SizedBox(
                width: double.infinity,
                height: AppSize.appBarHeight,
              ),
            ),
          ],
        );
        child = botToastBuilder(context, child);
        return child;
      },
      initialRoute: AppPages.initial,
    );
  }
}
