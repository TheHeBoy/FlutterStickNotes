import 'package:get/get.dart';

import 'logic.dart';

class SettingToolBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingToolBarLogic());
  }
}
