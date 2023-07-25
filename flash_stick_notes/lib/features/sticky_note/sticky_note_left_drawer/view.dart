import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flash_stick_notes/core/resources/size_manager.dart';
import 'package:flash_stick_notes/features/sticky_note/logic.dart';

import '../../../app/data/database/sqlite_database.dart';
import 'logic.dart';

class StickyNoteLeftDrawerComponent extends StatelessWidget {
  StickyNoteLeftDrawerComponent({Key? key}) : super(key: key);
  final logic = Get.put(StickyNoteLeftDrawerLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Drawer(
          width: MediaQuery.of(Get.context!).size.width * 0.9,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(AppSize.appBarHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_outlined),
                    onPressed: () async {
                      await logic.addNote();
                      Get.back();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {
                      logic.toSettingPage();
                    },
                  )
                ],
              ),
            ),
            body: Container(
                padding: const EdgeInsets.all(AppPadding.appPadding),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: logic.notes.length,
                    itemBuilder: (content, index) {
                      return _cardItem(logic.notes[index]);
                    })),
          ));
    });
  }

  _cardItem(Note note) {
    return Card(
        color: Theme.of(Get.context!).canvasColor,
        elevation: 0,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            StickyNoteLogic stickyNoteLogic = Get.find<StickyNoteLogic>();
            stickyNoteLogic.setCurrentNote(note);
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.appPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                note.plainContent.isBlank!
                    ? "请输入内容"
                    : _subString(note.plainContent),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppPadding.appPadding),
              Text(
                note.plainContent.isBlank! ? "请输入内容" : note.plainContent,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: AppPadding.appPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd').format(note.date),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  _operation(note)
                ],
              )
            ]),
          ),
        ));
  }

  _operation(Note note) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz_outlined), // 这将设置图标为三个垂直的点
      tooltip: "",
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("删除"),
        )
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('确定删除便签吗'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('取消'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: const Text('确定'),
                      onPressed: () async {
                        logic.deleteNote(note);
                        Get.back();
                      },
                    ),
                  ],
                );
              },
            );
            break;
        }
      },
    );
  }

  //截取字符串中第一行中的前十个字符
  _subString(String str) {
    int newlineIndex = str.indexOf('\n'); // 找到换行符的位置
    if (newlineIndex == -1) {
      // 如果找不到换行符，说明只有一行
      newlineIndex = str.length; // 直接取整个字符串的长度
    }

    String firstLine = str.substring(0, newlineIndex); // 截取第一行

    String limitedFirstLine = firstLine;
    if (firstLine.length > 20) {
      limitedFirstLine =
          firstLine.substring(0, 20); // 如果第一行超过10个字符，只取前10个字符，并添加省略号
    }
    return limitedFirstLine;
  }
}
