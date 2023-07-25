import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart' hide Value;
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';

import '../../../features/setting/logic.dart';

part 'sqlite_database.g.dart';

@DataClassName("Note")
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text()();

  TextColumn get plainContent => text()();

  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();
}

@DataClassName("AppToolBar")
class AppToolBars extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get toolbarEnum => textEnum<ToolbarButtons>()();

  IntColumn get order => integer()();

  BoolColumn get enable => boolean().withDefault(const Constant(true))();
}

@DataClassName("Setting")
class Settings extends Table {
  TextColumn get key => textEnum<SettingEnums>()();

  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [Notes, AppToolBars, Settings],
)
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  static init() async {
    Get.put(AppDataBase());
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll(); // create all tables

        List<AppToolBarsCompanion> toolbars = const [
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.bold), enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.italic), enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.underline),
              enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.strikeThrough),
              enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.listBullets),
              enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.listChecks),
              enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.clearFormat),
              enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.image), enable: Value(true)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.undo), enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.redo), enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.fontFamily),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.fontSize),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.subscript),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.superscript),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.small), enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.inlineCode),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.color), enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.backgroundColor),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.centerAlignment),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.leftAlignment),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.rightAlignment),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.justifyAlignment),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.direction),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.headerStyle),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.listNumbers),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.codeBlock),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.quote), enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.indentIncrease),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.indentDecrease),
              enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.link), enable: Value(false)),
          AppToolBarsCompanion(
              toolbarEnum: Value(ToolbarButtons.search), enable: Value(false)),
        ];

        for (int i = 0; i < toolbars.length; i++) {
          insertAppToolBar(toolbars[i].copyWith(order: Value(i)));
        }

        insertSetting(SettingsCompanion(
            key: const Value(SettingEnums.showToolbar),
            value: Value(true.toString())));
        insertSetting(SettingsCompanion(
            key: const Value(SettingEnums.bootstrap),
            value: Value(true.toString())));
        insertSetting(SettingsCompanion(
            key: const Value(SettingEnums.showWindow),
            value: Value(jsonEncode(
                HotKey(KeyCode.f1, modifiers: [KeyModifier.alt]).toJson()))));
        insertSetting(SettingsCompanion(
            key: const Value(SettingEnums.theme),
            value: Value(material.ThemeMode.dark.name)));
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // we added the dueDate property in the change from version 1 to
          // version 2
        }
        if (from < 3) {
          // we added the priority property in the change from version 1 or 2
          // to version 3
        }
      },
    );
  }

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  // *************Note***************
  //READ
  Future<List<Note>> getNotes() => select(notes).get();

  Future<Note> getNoteById(int id) =>
      (select(notes)..where((e) => e.id.equals(id))).getSingle();

  Stream<List<Note>> watchNotes() => select(notes).watch();

  //INSERT
  Future<Note> insertNote(NotesCompanion done) =>
      into(notes).insertReturning(done);

  Future<Note> insertEmptyNote() => into(notes).insertReturning(
      const NotesCompanion(content: Value(""), plainContent: Value("")));

  //Update
  Future updateNote(Note done) => update(notes).replace(done);

  //Delete
  Future deleteNote(Note done) => delete(notes).delete(done);

  //*************AppToolBar***************
  //Read
  Future<List<AppToolBar>> getAppToolBars() => select(appToolBars).get();

  Future<AppToolBar> getAppToolBarById(int id) =>
      (select(appToolBars)..where((e) => e.id.equals(id))).getSingle();

  Stream<List<AppToolBar>> watchAppToolBars() => select(appToolBars).watch();

  //INSERT
  Future<AppToolBar> insertAppToolBar(AppToolBarsCompanion done) =>
      into(appToolBars).insertReturning(done);

  //Update
  Future updateAppToolBar(AppToolBar done) => update(appToolBars).replace(done);

  //Delete
  Future deleteAppToolBar(AppToolBar done) => delete(appToolBars).delete(done);

  //*************Setting***************
  //Read
  Future<List<Setting>> getSettings() => select(settings).get();

  Future<Setting> getSettingById(SettingEnums key) =>
      (select(settings)..where((e) => e.key.equals(key.name))).getSingle();

  Stream<List<Setting>> watchSettings() => select(settings).watch();

  Stream<Setting> watchSetting(SettingEnums key) =>
      (select(settings)..where((done) => done.key.equals(key.name)))
          .watchSingle();

  //INSERT
  Future<Setting> insertSetting(SettingsCompanion done) =>
      into(settings).insertReturning(done);

  //Update
  Future updateSetting(Setting done) => update(settings).replace(done);

  //Delete
  Future deleteSetting(Setting done) => delete(settings).delete(done);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    Get.log("数据库文件路径：${file.path}");
    return NativeDatabase(file);
  });
}
