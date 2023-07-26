
import 'package:get_storage/get_storage.dart';

class AppStorage {
  AppStorage._();

  static const String container = "hotKeyBox";

  static final box = GetStorage();
  static final hotkeyBox = GetStorage(container);

  static const String currentNoteIdKey = "currentNoteId";
  static const String showToolBarKey = "showToolBar";
  static const String isShowHotKey = "isShowHotKey";

  static init() async {
    await GetStorage.init();
    await GetStorage.init(container);
  }

  static int? readCurrentNoteId() {
    return box.read(currentNoteIdKey);
  }

  static void delCurrentNoteId(){
    box.remove(currentNoteIdKey);
  }

  static void writeCurrentNoteId(int id) {
    box.write(currentNoteIdKey, id);
  }
}
