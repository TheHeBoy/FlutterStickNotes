import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/resources/size_manager.dart';
import '../sticky_note/toolbar_button/toolbar_button.dart';
import 'logic.dart';

class SettingToolBarPage extends StatelessWidget {
  SettingToolBarPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingToolBarLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: AppSize.appBarIcon),
        toolbarHeight: AppSize.appBarSettingHeight,
        title: const Text('工具栏'),
      ),
      body: Obx(() {
        return ReorderableListView(
          scrollDirection: Axis.vertical,
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            logic.updateOrder(oldIndex, newIndex);
          },
          footer: null,
          children: logic.mapButtons.value.entries.map((e) {
            final appToolbar = e.key;
            final widget = e.value;
            return ListTile(
              key: widget.key,
              title: Text(appToolbar.toolbarEnum.name),
              leading: IgnorePointer(
                ignoring: true, // 设置为true时，Widget将被禁用，设置为false时将恢复可点击状态
                child: widget,
              ),
              trailing: Padding(
                  padding: const EdgeInsets.only(right: AppPadding.appPadding),
                  child: Switch(
                      value: appToolbar.enable, onChanged: (bool value) {
                    logic.updateEnable(appToolbar, value);
                  })),
            );
          }).toList(),
        );
      }),
    );
  }
}
