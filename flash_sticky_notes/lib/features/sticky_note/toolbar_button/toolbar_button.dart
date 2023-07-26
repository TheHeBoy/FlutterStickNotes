import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/translations.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';

import 'package:flash_sticky_notes/features/setting/logic.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../../../app/data/database/sqlite_database.dart';

/// The default size of the icon of a button.
const double kDefaultIconSize = 18;

/// The factor of how much larger the button is in relation to the icon.
const double kIconButtonFactor = 1.77;

/// The horizontal margin between the contents of each toolbar section.
const double kToolbarSectionSpacing = 4;

class ToolbarButton {
  static final fontSizes = {
    'Small'.i18n: 'small',
    'Large'.i18n: 'large',
    'Huge'.i18n: 'huge',
    'Clear'.i18n: '0'
  };

  static final fontFamilies = {
    'Sans Serif': 'sans-serif',
    'Serif': 'serif',
    'Monospace': 'monospace',
    'Ibarra Real Nova': 'ibarra-real-nova',
    'SquarePeg': 'square-peg',
    'Nunito': 'nunito',
    'Pacifico': 'pacifico',
    'Roboto Mono': 'roboto-mono',
    'Clear'.i18n: 'Clear'
  };

  static final buttonTooltips = <ToolbarButtons, String>{
    ToolbarButtons.undo: 'Undo'.i18n,
    ToolbarButtons.redo: 'Redo'.i18n,
    ToolbarButtons.fontFamily: 'Font family'.i18n,
    ToolbarButtons.fontSize: 'Font size'.i18n,
    ToolbarButtons.bold: 'Bold'.i18n,
    ToolbarButtons.subscript: 'Subscript'.i18n,
    ToolbarButtons.superscript: 'Superscript'.i18n,
    ToolbarButtons.italic: 'Italic'.i18n,
    ToolbarButtons.small: 'Small'.i18n,
    ToolbarButtons.underline: 'Underline'.i18n,
    ToolbarButtons.strikeThrough: 'Strike through'.i18n,
    ToolbarButtons.inlineCode: 'Inline code'.i18n,
    ToolbarButtons.color: 'Font color'.i18n,
    ToolbarButtons.backgroundColor: 'Background color'.i18n,
    ToolbarButtons.clearFormat: 'Clear format'.i18n,
    ToolbarButtons.leftAlignment: 'Align left'.i18n,
    ToolbarButtons.centerAlignment: 'Align center'.i18n,
    ToolbarButtons.rightAlignment: 'Align right'.i18n,
    ToolbarButtons.justifyAlignment: 'Justify win width'.i18n,
    ToolbarButtons.direction: 'Text direction'.i18n,
    ToolbarButtons.headerStyle: 'Header style'.i18n,
    ToolbarButtons.listNumbers: 'Numbered list'.i18n,
    ToolbarButtons.listBullets: 'Bullet list'.i18n,
    ToolbarButtons.listChecks: 'Checked list'.i18n,
    ToolbarButtons.codeBlock: 'Code block'.i18n,
    ToolbarButtons.quote: 'Quote'.i18n,
    ToolbarButtons.indentIncrease: 'Increase indent'.i18n,
    ToolbarButtons.indentDecrease: 'Decrease indent'.i18n,
    ToolbarButtons.link: 'Insert URL'.i18n,
    ToolbarButtons.search: 'Search'.i18n,
  };

  static final db = Get.find<AppDataBase>();

  static String getButtonTooltip(Key key) {
    return buttonTooltips[(key as ObjectKey).value as ToolbarButtons]!;
  }

  static List<Widget> getToolButtons(controller,
      {toolbarIconSize = kDefaultIconSize,
      iconTheme,
      afterButtonPressed,
      axis = Axis.horizontal,
      dialogTheme}) {
    return [
      HistoryButton(
        key: const ObjectKey(ToolbarButtons.undo),
        icon: Icons.undo_outlined,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.undo],
        controller: controller,
        undo: true,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      HistoryButton(
        key: const ObjectKey(ToolbarButtons.redo),
        icon: Icons.redo_outlined,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.redo],
        controller: controller,
        undo: false,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      QuillFontFamilyButton(
        key: const ObjectKey(ToolbarButtons.fontFamily),
        iconTheme: iconTheme,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.fontFamily],
        attribute: Attribute.font,
        controller: controller,
        rawItemsMap: fontFamilies,
        afterButtonPressed: afterButtonPressed,
      ),
      QuillFontSizeButton(
        key: const ObjectKey(ToolbarButtons.fontSize),
        iconTheme: iconTheme,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.fontSize],
        attribute: Attribute.size,
        controller: controller,
        rawItemsMap: fontSizes,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.bold),
        attribute: Attribute.bold,
        icon: Icons.format_bold,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.bold],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.subscript),
        attribute: Attribute.subscript,
        icon: Icons.subscript,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.subscript],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.superscript),
        attribute: Attribute.superscript,
        icon: Icons.superscript,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.superscript],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.italic),
        attribute: Attribute.italic,
        icon: Icons.format_italic,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.italic],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.small),
        attribute: Attribute.small,
        icon: Icons.format_size,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.small],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.underline),
        attribute: Attribute.underline,
        icon: Icons.format_underline,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.underline],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.strikeThrough),
        attribute: Attribute.strikeThrough,
        icon: Icons.format_strikethrough,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.strikeThrough],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.inlineCode),
        attribute: Attribute.inlineCode,
        icon: Icons.code,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.inlineCode],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ColorButton(
        key: const ObjectKey(ToolbarButtons.color),
        icon: Icons.color_lens,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.color],
        controller: controller,
        background: false,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ColorButton(
        key: const ObjectKey(ToolbarButtons.backgroundColor),
        icon: Icons.format_color_fill,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.backgroundColor],
        controller: controller,
        background: true,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ClearFormatButton(
        key: const ObjectKey(ToolbarButtons.clearFormat),
        icon: Icons.format_clear,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.clearFormat],
        controller: controller,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      SelectAlignmentButton(
        key: const ObjectKey(ToolbarButtons.leftAlignment),
        controller: controller,
        tooltips: buttonTooltips,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        showLeftAlignment: true,
        showCenterAlignment: false,
        showRightAlignment: false,
        showJustifyAlignment: false,
        afterButtonPressed: afterButtonPressed,
      ),
      SelectAlignmentButton(
        key: const ObjectKey(ToolbarButtons.centerAlignment),
        controller: controller,
        tooltips: buttonTooltips,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        showLeftAlignment: false,
        showCenterAlignment: true,
        showRightAlignment: false,
        showJustifyAlignment: false,
        afterButtonPressed: afterButtonPressed,
      ),
      SelectAlignmentButton(
        key: const ObjectKey(ToolbarButtons.rightAlignment),
        controller: controller,
        tooltips: buttonTooltips,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        showLeftAlignment: false,
        showCenterAlignment: false,
        showRightAlignment: true,
        showJustifyAlignment: false,
        afterButtonPressed: afterButtonPressed,
      ),
      SelectAlignmentButton(
        key: const ObjectKey(ToolbarButtons.justifyAlignment),
        controller: controller,
        tooltips: buttonTooltips,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        showLeftAlignment: false,
        showCenterAlignment: false,
        showRightAlignment: false,
        showJustifyAlignment: true,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.direction),
        attribute: Attribute.rtl,
        tooltip: buttonTooltips[ToolbarButtons.direction],
        controller: controller,
        icon: Icons.format_textdirection_r_to_l,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      SelectHeaderStyleButton(
        key: const ObjectKey(ToolbarButtons.headerStyle),
        tooltip: buttonTooltips[ToolbarButtons.headerStyle],
        controller: controller,
        axis: axis,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.listNumbers),
        attribute: Attribute.ol,
        tooltip: buttonTooltips[ToolbarButtons.listNumbers],
        controller: controller,
        icon: Icons.format_list_numbered,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.listBullets),
        attribute: Attribute.ul,
        tooltip: buttonTooltips[ToolbarButtons.listBullets],
        controller: controller,
        icon: Icons.format_list_bulleted,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleCheckListButton(
        key: const ObjectKey(ToolbarButtons.listChecks),
        attribute: Attribute.unchecked,
        tooltip: buttonTooltips[ToolbarButtons.listChecks],
        controller: controller,
        icon: Icons.check_box,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.codeBlock),
        attribute: Attribute.codeBlock,
        tooltip: buttonTooltips[ToolbarButtons.codeBlock],
        controller: controller,
        icon: Icons.code,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ToggleStyleButton(
        key: const ObjectKey(ToolbarButtons.quote),
        attribute: Attribute.blockQuote,
        tooltip: buttonTooltips[ToolbarButtons.quote],
        controller: controller,
        icon: Icons.format_quote,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      IndentButton(
        key: const ObjectKey(ToolbarButtons.indentIncrease),
        icon: Icons.format_indent_increase,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.indentIncrease],
        controller: controller,
        isIncrease: true,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      IndentButton(
        key: const ObjectKey(ToolbarButtons.indentDecrease),
        icon: Icons.format_indent_decrease,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.indentDecrease],
        controller: controller,
        isIncrease: false,
        iconTheme: iconTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      LinkStyleButton(
        key: const ObjectKey(ToolbarButtons.link),
        tooltip: buttonTooltips[ToolbarButtons.link],
        controller: controller,
        iconSize: toolbarIconSize,
        iconTheme: iconTheme,
        dialogTheme: dialogTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      SearchButton(
        key: const ObjectKey(ToolbarButtons.search),
        icon: Icons.search,
        iconSize: toolbarIconSize,
        tooltip: buttonTooltips[ToolbarButtons.search],
        controller: controller,
        iconTheme: iconTheme,
        dialogTheme: dialogTheme,
        afterButtonPressed: afterButtonPressed,
      ),
      ImageButton(
        key: const ObjectKey(ToolbarButtons.image),
        icon: Icons.image,
        iconSize: toolbarIconSize,
        controller: controller,
        onImagePickCallback: _onImagePickCallback,
        filePickImpl: _openFileSystemPickerForDesktop,
        mediaPickSettingSelector: _selectMediaPickSetting,
        iconTheme: iconTheme,
        dialogTheme: dialogTheme,
      )
    ];
  }

  static Stream<SplayTreeMap<AppToolBar, Widget>> getOrderButtons(controller,
      {enable}) {
    return rxdart.Rx.combineLatest2(
      db.watchSetting(SettingEnums.theme),
      db.watchAppToolBars(),
      (Setting setting, List<AppToolBar> data) {
        final quillBtnsMap = {};
        for (var btn in getToolButtons(controller,
            iconTheme: QuillIconTheme(
                iconUnselectedFillColor: Get.theme.scaffoldBackgroundColor))) {
          quillBtnsMap[(btn.key! as ObjectKey).value as ToolbarButtons] = btn;
        }
        final appToolbars = data;
        SplayTreeMap<AppToolBar, Widget> orderBtns =
            SplayTreeMap<AppToolBar, Widget>(
                (o1, o2) => o1.order.compareTo(o2.order));
        for (var appToolbar in appToolbars) {
          final key = appToolbar.toolbarEnum;
          if (enable != null) {
            if (enable == appToolbar.enable) {
              orderBtns[appToolbar] = quillBtnsMap[key]!;
            }
          } else {
            orderBtns[appToolbar] = quillBtnsMap[key]!;
          }
        }
        return orderBtns;
      },
    );
  }

  static Future<String> _onImagePickCallback(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  static Future<String?> _openFileSystemPickerForDesktop(
      BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    return result?.files.single.path;
  }

  static Future<MediaPickSetting?> _selectMediaPickSetting(
      BuildContext context) {
    return Future(() => MediaPickSetting.Gallery);
  }
}
