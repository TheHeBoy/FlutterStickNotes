import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:flash_sticky_notes/features/setting/logic.dart';
import '../../app/data/app_storage.dart';
import '../../app/data/database/sqlite_database.dart';
import 'toolbar_button/toolbar_button.dart';

class StickyNoteLogic extends GetxController {
  var isAppBarVisible = true.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late QuillController quillCtr = QuillController.basic();
  late FocusNode focusNode = FocusNode();
  final db = Get.find<AppDataBase>();
  var quillBtns = <Widget>[].obs;
  var showToolBar = true.obs;

  @override
  void onInit() {
    super.onInit();
    showToolBar.bindStream(db
        .watchSetting(SettingEnums.showToolbar)
        .map((data) => bool.parse(data.value)));
    int? currentNoteId = AppStorage.readCurrentNoteId();
    if (currentNoteId == null) {
      setCurrentNote();
    } else {
      db.getNoteById(currentNoteId).then((value) {
        setCurrentNote(value);
      });
    }
  }

  void setCurrentNote([note]) {
    _setNewQuillCtr();
    quillCtr.addListener(() async {
      note = note ?? await db.insertEmptyNote();
      db.updateNote(note!.copyWith(
          content: jsonEncode(quillCtr.document.toDelta().toJson()),
          plainContent: quillCtr.document.toPlainText()));
    });

    if (note != null && note!.content.isNotEmpty) {
      quillCtr.document = Document.fromJson(jsonDecode(note!.content));
      AppStorage.writeCurrentNoteId(note!.id);
    }
    update();
  }

  // void setFocus() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     quillCtr.updateSelection(quillCtr.selection, ChangeSource.REMOTE);
  //   });
  // }

  // void setIsAppBarVisible(bool flag) {
  // if (flag != isAppBarVisible.value) {
  //   isAppBarVisible.value = flag;
  //   isAnimated = true;
  //   //可见
  //   if(flag){
  //     setFocus();
  //   }
  // }
  // }

  openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  _setNewQuillCtr() {
    quillCtr.dispose();
    quillCtr = QuillController.basic();
    quillBtns.bindStream(
        ToolbarButton.getOrderButtons(quillCtr, enable: true).map((data) {
      return data.values.toList();
    }));
    focusNode.dispose();
    focusNode = FocusNode();
  }
}
