import 'package:get/get.dart' hide Value;
import 'package:flash_stick_notes/app/data/database/sqlite_database.dart';
import 'package:flash_stick_notes/app/routes/app_pages.dart';
import 'package:flash_stick_notes/features/sticky_note/logic.dart';

import '../../../app/data/app_storage.dart';

class StickyNoteLeftDrawerLogic extends GetxController {
  final db = Get.find<AppDataBase>();
  final stickyNoteLogic = Get.find<StickyNoteLogic>();
  final notes = <Note>[].obs;
  @override
  void onInit() {
    super.onInit();
    notes.bindStream(db.watchNotes());
  }

  toSettingPage() {
    Get.toNamed(Routes.setting);
  }

  addNote() async {
    Note note = await db.insertEmptyNote();
    stickyNoteLogic.setCurrentNote(note);
  }

  deleteNote(Note note) async {
    List nodeList = await db.getNotes();
    if(nodeList.length == 1){
      db.deleteNote(note);
      AppStorage.delCurrentNoteId();
      stickyNoteLogic.setCurrentNote(null);
    }else if(note.id == AppStorage.readCurrentNoteId()){
      await db.deleteNote(note);
      List nodeList = await db.getNotes();
      if(nodeList.isEmpty){
        AppStorage.delCurrentNoteId();
        stickyNoteLogic.setCurrentNote();
      }else{
        stickyNoteLogic.setCurrentNote(nodeList[0]);
      }
    }else{
      db.deleteNote(note);
    }
  }
}
