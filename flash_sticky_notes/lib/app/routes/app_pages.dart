import 'package:get/get.dart';
import '../../features/setting/binding.dart';
import '../../features/setting/view.dart';
import '../../features/setting_theme/binding.dart';
import '../../features/setting_theme/view.dart';
import '../../features/setting_tool_bar/binding.dart';
import '../../features/setting_tool_bar/view.dart';
import '../../features/sticky_note/binding.dart';
import '../../features/sticky_note/view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.stickyNote;

  static final routes = [
    GetPage(
      name: Routes.stickyNote,
      page: () => StickyNotePage(),
      binding: StickyNoteBinding(),
    ),
    GetPage(
      name: Routes.setting,
      page: () => SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.settingToolBar,
      page: () => SettingToolBarPage(),
      binding: SettingToolBarBinding(),
    ),
    GetPage(
      name: Routes.settingTheme,
      page: () => SettingThemePage(),
      binding: SettingThemeBinding(),
    ),
  ];
}
