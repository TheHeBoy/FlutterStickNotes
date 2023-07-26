import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/common_widgets/preference_list/preference_list.dart';
import '../../core/resources/size_manager.dart';
import 'logic.dart';

class SettingThemePage extends StatelessWidget {
  SettingThemePage({Key? key}) : super(key: key);

  final logic = Get.find<SettingThemeLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(logic.themeGroup.value == null) return Container();
      return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(size: AppSize.appBarIcon),
            toolbarHeight: AppSize.appBarSettingHeight,
            title: const Text('主题模式'),
          ),
          body: PreferenceList(
            children: [
              PreferenceListSection(
                children: [
                  PreferenceListRadioItem(
                    value: ThemeMode.light,
                    groupValue: logic.themeGroup.value!,
                    onChanged: logic.updateTheme,
                    title: const Text(
                      '浅色',
                    ),
                  ),
                  PreferenceListRadioItem(
                    value: ThemeMode.dark,
                    groupValue: logic.themeGroup.value!,
                    onChanged: logic.updateTheme,
                    title: const Text('深色'),
                  ),
                  PreferenceListRadioItem(
                    value: ThemeMode.system,
                    groupValue: logic.themeGroup.value!,
                    onChanged: logic.updateTheme,
                    title: const Text(
                      '跟随系统',
                    ),
                  ),
                ],
              ),
            ],
          ));
    });
  }
}
