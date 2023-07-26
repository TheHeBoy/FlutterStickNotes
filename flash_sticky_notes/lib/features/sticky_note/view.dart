import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flash_sticky_notes/app/common_widgets/custom_app_bar/view.dart';
import 'package:flash_sticky_notes/core/resources/size_manager.dart';
import 'logic.dart';
import 'sticky_note_left_drawer/view.dart';

class StickyNotePage extends StatelessWidget {
  StickyNotePage({Key? key}) : super(key: key);

  final logic = Get.find<StickyNoteLogic>();

  Timer? _selectAllTimer;

  _SelectionType _selectionType = _SelectionType.none;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        key: logic.scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.appBarHeight),
          child: CustomAppBarComponent(),
        ),
        backgroundColor: Theme.of(Get.context!).canvasColor,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GetBuilder<StickyNoteLogic>(builder: (logic) {
            return _editBody();
          }),
        ),
        bottomNavigationBar: logic.showToolBar.value ? _editToolBar() : null,
        drawer: _drawerPage(),
      );
    });
  }

  _editBody() {
    return QuillEditor(
        placeholder: "请输入内容",
        onTapUp: (details, _) {
          return _onTripleClickSelection();
        },
        scrollController: ScrollController(),
        enableSelectionToolbar: true,
        controller: logic.quillCtr,
        scrollable: true,
        focusNode: logic.focusNode,
        autoFocus: false,
        readOnly: false,
        expands: true,
        padding: const EdgeInsets.all(AppPadding.appPadding),
        onImagePaste: _onImagePaste,
        embedBuilders: [
          ...FlutterQuillEmbeds.builders(),
        ]);
  }

  _editToolBar() {
    return QuillToolbar(
      locale: Get.locale,
      toolbarSectionSpacing: 0,
      sectionDividerSpace: 0,
      color: Get.theme.scaffoldBackgroundColor,
      multiRowsDisplay: false,
      children: logic.quillBtns.value,
    );
  }

  _drawerPage() {
    return StickyNoteLeftDrawerComponent();
  }

  Future<String> _onImagePaste(Uint8List imageBytes) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = await File(
            '${appDocDir.path}/${basename('${DateTime.now().millisecondsSinceEpoch}.png')}')
        .writeAsBytes(imageBytes, flush: true);
    return file.path.toString();
  }

  bool _onTripleClickSelection() {
    final controller = logic.quillCtr;

    _selectAllTimer?.cancel();
    _selectAllTimer = null;

    if (controller.selection.isCollapsed) {
      _selectionType = _SelectionType.none;
    }

    if (_selectionType == _SelectionType.none) {
      _selectionType = _SelectionType.word;
      _startTripleClickTimer();
      return false;
    }

    if (_selectionType == _SelectionType.word) {
      final child = controller.document.queryChild(
        controller.selection.baseOffset,
      );
      final offset = child.node?.documentOffset ?? 0;
      final length = child.node?.length ?? 0;

      final selection = TextSelection(
        baseOffset: offset,
        extentOffset: offset + length,
      );

      controller.updateSelection(selection, ChangeSource.REMOTE);

      _selectionType = _SelectionType.none;

      _startTripleClickTimer();

      return true;
    }

    return false;
  }

  void _startTripleClickTimer() {
    _selectAllTimer = Timer(const Duration(milliseconds: 500), () {
      _selectionType = _SelectionType.none;
    });
  }
}

enum _SelectionType {
  none,
  word,
}
