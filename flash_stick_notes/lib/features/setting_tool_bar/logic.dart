// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../app/data/database/sqlite_database.dart';
import '../sticky_note/toolbar_button/toolbar_button.dart';

class SettingToolBarLogic extends GetxController {
  var mapButtons = <AppToolBar, Widget>{}.obs;

  final db = Get.find<AppDataBase>();

  @override
  void onInit() {
    mapButtons.bindStream(ToolbarButton.getOrderButtons(QuillController.basic()));
    super.onInit();
  }

  updateOrder(int oldIndex,int newIndex){
    var oldToolBar = mapButtons.value.keys.where((element) => element.order == oldIndex).single;
    var newToolBar = mapButtons.value.keys.where((element) => element.order == newIndex).single;

    db.updateAppToolBar(oldToolBar.copyWith(order: newIndex));
    db.updateAppToolBar(newToolBar.copyWith(order: oldIndex));
  }

  updateEnable(AppToolBar appToolbar,bool enable){
    db.updateAppToolBar(appToolbar.copyWith(enable: enable));
  }
}
