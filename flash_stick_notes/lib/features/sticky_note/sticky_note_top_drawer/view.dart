import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import 'logic.dart';

class StickyNoteTopDrawerComponent extends StatelessWidget {
  StickyNoteTopDrawerComponent({Key? key}) : super(key: key);

  final logic = Get.put(StickyNoteTopDrawerLogic());

  static show() {
    showGeneralDialog(
      context: Get.context!,
      barrierLabel:
          MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
      barrierDismissible: true,
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: const Offset(0.0, 0.0),
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          )),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.white,
            child: Center(
              child: StickyNoteTopDrawerComponent(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: InkWell(
                child: Container(
                  color: AppLightTheme.getColor(),
                  child: const Center(child: Text('白间',style: TextStyle(color: Colors.black),),),
                ),
                onTap: (){
                  Get.changeTheme(AppLightTheme.themeData);
                  Get.back();
                },
              )),
          Expanded(
              child: InkWell(
                child: Container(
                  color: AppDarkTheme.getColor(),
                  child: const Center(child: Text('夜间'),),
                ),
                onTap: (){
                  Get.changeTheme(AppDarkTheme.themeData);
                  Get.back();
                },
              )),
        ],
      ),
    );
  }
}
