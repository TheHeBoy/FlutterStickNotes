import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flash_sticky_notes/features/sticky_note/logic.dart';

import '../../../features/sticky_note/sticky_note_top_drawer/view.dart';

class CustomAppBarLogic extends GetxController {

  var isAlwaysOnTop = true.obs;
  final stickyNoteLogic = Get.find<StickyNoteLogic>();

  void setIsAlwaysOnTop() async {
    isAlwaysOnTop.value = !await windowManager.isAlwaysOnTop();
    windowManager.setAlwaysOnTop(isAlwaysOnTop.value);
  }

  void openLeftDrawer() {
    stickyNoteLogic.openDrawer();
  }


  void openTopDrawer(){
    StickyNoteTopDrawerComponent.show();
  }
}
