import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:flash_stick_notes/core/resources/size_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import '../../app/common_widgets/preference_list/preference_list.dart';
import '../../app/routes/app_pages.dart';
import 'logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.settingsMap.isEmpty) return Container();
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: AppSize.appBarSettingHeight,
          title: Text('设置', style: Theme.of(context).textTheme.bodyMedium),
        ),
        body: PreferenceList(
          children: [
            PreferenceListSection(
              title: const Text('快捷键'),
              children: [
                PreferenceListItem(
                  title: const Text('显示/隐藏'),
                  detailText: logic.showWindow.value == null
                      ? const Text('')
                      : _hotKeyView(logic.showWindow.value!),
                  onTap: () {
                    _hotKeyRecorderDialog();
                  },
                )
              ],
            ),
            PreferenceListSection(
              title: const Text('工具栏'),
              children: [
                PreferenceListSwitchItem(
                    title: const Text('显示'),
                    value: bool.parse(
                        logic.settingsMap[SettingEnums.showToolbar]!),
                    onChanged: (bool value) {
                      logic.updateSetting(
                          SettingEnums.showToolbar, value.toString());
                    }),
                PreferenceListItem(
                  title: const Text('自定义'),
                  onTap: () {
                    Get.toNamed(Routes.settingToolBar);
                  },
                )
              ],
            ),
            PreferenceListSection(
              title: const Text('外观'),
              children: [
                PreferenceListItem(
                  title: const Text('主题模式'),
                  onTap: () {
                    Get.toNamed(Routes.settingTheme);
                  },
                )
              ],
            ),
            PreferenceListSection(
              title: const Text('常规'),
              children: [
                PreferenceListSwitchItem(
                    title: const Text('开机自启'),
                    value: bool.parse(
                        logic.settingsMap[SettingEnums.bootstrap]!),
                    onChanged: (bool value) {
                      value ? launchAtStartup.enable() : launchAtStartup.disable();
                      logic.updateSetting(
                          SettingEnums.bootstrap, value.toString());
                    }),
              ],
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton.small(
        //     onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => DriftDbViewer(Get.find<AppDataBase>())))),
      );
    });
  }

  _hotKeyRecorderDialog() {
    final newHotKey = Rx<HotKey?>(null);
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('直接按键盘进行设置', style: Theme.of(context).textTheme.bodyLarge),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      HotKeyRecorder(
                        onHotKeyRecorded: (hotKey) {
                          newHotKey.value = hotKey;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            Obx(() {
              return TextButton(
                onPressed: newHotKey.value == null
                    ? null
                    : () {
                        logic.updateSetting(SettingEnums.showWindow,
                            jsonEncode(newHotKey.value!));
                        Get.back();
                      },
                child: const Text('确定'),
              );
            }),
          ],
        );
      },
    );
  }

  _hotKeyView(HotKey hotKey) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (KeyModifier keyModifier in hotKey.modifiers ?? []) ...[
          Kbd(
            keyModifier.keyLabel,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto Mono',
              ),
            ),
          ),
        ],
        Kbd(
          hotKey.keyCode.keyLabel,
        ),
      ],
    );
  }
}

class Kbd extends StatelessWidget {
  const Kbd(
    this.label, {
    super.key,
    this.brightness,
    this.size,
  });

  final String label;

  final Brightness? brightness;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
