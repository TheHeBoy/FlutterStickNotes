import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flash_stick_notes/core/resources/size_manager.dart';

import 'logic.dart';

class CustomAppBarComponent extends StatelessWidget {
  CustomAppBarComponent({Key? key}) : super(key: key);

  final logic = Get.put(CustomAppBarLogic());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.appBarHeight,
      child: Container(
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
        padding: const EdgeInsets.only(
            left: AppPadding.appPadding, right: AppPadding.appPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _menu(),
            Row(children: [
              Container(
                padding: const EdgeInsets.only(
                    left: AppPadding.appPadding, right: AppPadding.appPadding),
                child: _alwaysOnTop(),
              ),
              // _moreMenu()
            ])
          ],
        ),
      ),
    );
  }

  _menu() {
    return SizedBox(
      width: AppSize.appBarIcon,
      height: AppSize.appBarIcon,
      child: InkWell(
        child: const Icon(Icons.menu_outlined),
        onTap: () {
          logic.openLeftDrawer();
        },
      ),
    );
  }

  _alwaysOnTop() {
    return SizedBox(
      width: AppSize.appBarIcon,
      height: AppSize.appBarIcon,
      child: InkWell(
        child: Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            transformAlignment: Alignment.center,
            transform: Matrix4.rotationZ(
              logic.isAlwaysOnTop.value ? 0 : -0.8,
            ),
            child: Icon(
              logic.isAlwaysOnTop.value
                  ? FluentIcons.pin_20_filled
                  : FluentIcons.pin_20_regular,
              size: 20,
              color: logic.isAlwaysOnTop.value
                  ? Theme.of(Get.context!).primaryColor
                  : Theme.of(Get.context!).iconTheme.color,
            ),
          );
        }),
        onTap: () {
          logic.setIsAlwaysOnTop();
        },
      ),
    );
  }

  // _moreMenu() {
  //   return SizedBox(
  //     width: AppSize.appBarIcon,
  //     height: AppSize.appBarIcon,
  //     child: InkWell(
  //       child: const Icon(Icons.more_vert_outlined),
  //       onTap: () {
  //         logic.openTopDrawer();
  //       },
  //     ),
  //   );
  // }
}
