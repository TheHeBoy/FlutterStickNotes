import 'package:get/get.dart';

import 'logic.dart';

class SettingThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingThemeLogic());
  }
}
