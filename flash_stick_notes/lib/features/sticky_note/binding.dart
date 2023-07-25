import 'package:get/get.dart';

import 'logic.dart';

class StickyNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StickyNoteLogic());
  }
}
