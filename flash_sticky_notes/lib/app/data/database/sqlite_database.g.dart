// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqlite_database.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plainContentMeta =
      const VerificationMeta('plainContent');
  @override
  late final GeneratedColumn<String> plainContent = GeneratedColumn<String>(
      'plain_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [id, content, plainContent, date];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('plain_content')) {
      context.handle(
          _plainContentMeta,
          plainContent.isAcceptableOrUnknown(
              data['plain_content']!, _plainContentMeta));
    } else if (isInserting) {
      context.missing(_plainContentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      plainContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plain_content'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String content;
  final String plainContent;
  final DateTime date;
  const Note(
      {required this.id,
      required this.content,
      required this.plainContent,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['plain_content'] = Variable<String>(plainContent);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      content: Value(content),
      plainContent: Value(plainContent),
      date: Value(date),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      plainContent: serializer.fromJson<String>(json['plainContent']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'plainContent': serializer.toJson<String>(plainContent),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Note copyWith(
          {int? id, String? content, String? plainContent, DateTime? date}) =>
      Note(
        id: id ?? this.id,
        content: content ?? this.content,
        plainContent: plainContent ?? this.plainContent,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('plainContent: $plainContent, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, plainContent, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.content == this.content &&
          other.plainContent == this.plainContent &&
          other.date == this.date);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> content;
  final Value<String> plainContent;
  final Value<DateTime> date;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.plainContent = const Value.absent(),
    this.date = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required String plainContent,
    this.date = const Value.absent(),
  })  : content = Value(content),
        plainContent = Value(plainContent);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? plainContent,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (plainContent != null) 'plain_content': plainContent,
      if (date != null) 'date': date,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<String>? plainContent,
      Value<DateTime>? date}) {
    return NotesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      plainContent: plainContent ?? this.plainContent,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (plainContent.present) {
      map['plain_content'] = Variable<String>(plainContent.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('plainContent: $plainContent, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $AppToolBarsTable extends AppToolBars
    with TableInfo<$AppToolBarsTable, AppToolBar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppToolBarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _toolbarEnumMeta =
      const VerificationMeta('toolbarEnum');
  @override
  late final GeneratedColumnWithTypeConverter<ToolbarButtons, String>
      toolbarEnum = GeneratedColumn<String>('toolbar_enum', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ToolbarButtons>(
              $AppToolBarsTable.$convertertoolbarEnum);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable =
      GeneratedColumn<bool>('enable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("enable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, toolbarEnum, order, enable];
  @override
  String get aliasedName => _alias ?? 'app_tool_bars';
  @override
  String get actualTableName => 'app_tool_bars';
  @override
  VerificationContext validateIntegrity(Insertable<AppToolBar> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_toolbarEnumMeta, const VerificationResult.success());
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('enable')) {
      context.handle(_enableMeta,
          enable.isAcceptableOrUnknown(data['enable']!, _enableMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppToolBar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppToolBar(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      toolbarEnum: $AppToolBarsTable.$convertertoolbarEnum.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}toolbar_enum'])!),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      enable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable'])!,
    );
  }

  @override
  $AppToolBarsTable createAlias(String alias) {
    return $AppToolBarsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ToolbarButtons, String, String>
      $convertertoolbarEnum =
      const EnumNameConverter<ToolbarButtons>(ToolbarButtons.values);
}

class AppToolBar extends DataClass implements Insertable<AppToolBar> {
  final int id;
  final ToolbarButtons toolbarEnum;
  final int order;
  final bool enable;
  const AppToolBar(
      {required this.id,
      required this.toolbarEnum,
      required this.order,
      required this.enable});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $AppToolBarsTable.$convertertoolbarEnum;
      map['toolbar_enum'] = Variable<String>(converter.toSql(toolbarEnum));
    }
    map['order'] = Variable<int>(order);
    map['enable'] = Variable<bool>(enable);
    return map;
  }

  AppToolBarsCompanion toCompanion(bool nullToAbsent) {
    return AppToolBarsCompanion(
      id: Value(id),
      toolbarEnum: Value(toolbarEnum),
      order: Value(order),
      enable: Value(enable),
    );
  }

  factory AppToolBar.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppToolBar(
      id: serializer.fromJson<int>(json['id']),
      toolbarEnum: $AppToolBarsTable.$convertertoolbarEnum
          .fromJson(serializer.fromJson<String>(json['toolbarEnum'])),
      order: serializer.fromJson<int>(json['order']),
      enable: serializer.fromJson<bool>(json['enable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'toolbarEnum': serializer.toJson<String>(
          $AppToolBarsTable.$convertertoolbarEnum.toJson(toolbarEnum)),
      'order': serializer.toJson<int>(order),
      'enable': serializer.toJson<bool>(enable),
    };
  }

  AppToolBar copyWith(
          {int? id, ToolbarButtons? toolbarEnum, int? order, bool? enable}) =>
      AppToolBar(
        id: id ?? this.id,
        toolbarEnum: toolbarEnum ?? this.toolbarEnum,
        order: order ?? this.order,
        enable: enable ?? this.enable,
      );
  @override
  String toString() {
    return (StringBuffer('AppToolBar(')
          ..write('id: $id, ')
          ..write('toolbarEnum: $toolbarEnum, ')
          ..write('order: $order, ')
          ..write('enable: $enable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, toolbarEnum, order, enable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppToolBar &&
          other.id == this.id &&
          other.toolbarEnum == this.toolbarEnum &&
          other.order == this.order &&
          other.enable == this.enable);
}

class AppToolBarsCompanion extends UpdateCompanion<AppToolBar> {
  final Value<int> id;
  final Value<ToolbarButtons> toolbarEnum;
  final Value<int> order;
  final Value<bool> enable;
  const AppToolBarsCompanion({
    this.id = const Value.absent(),
    this.toolbarEnum = const Value.absent(),
    this.order = const Value.absent(),
    this.enable = const Value.absent(),
  });
  AppToolBarsCompanion.insert({
    this.id = const Value.absent(),
    required ToolbarButtons toolbarEnum,
    required int order,
    this.enable = const Value.absent(),
  })  : toolbarEnum = Value(toolbarEnum),
        order = Value(order);
  static Insertable<AppToolBar> custom({
    Expression<int>? id,
    Expression<String>? toolbarEnum,
    Expression<int>? order,
    Expression<bool>? enable,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (toolbarEnum != null) 'toolbar_enum': toolbarEnum,
      if (order != null) 'order': order,
      if (enable != null) 'enable': enable,
    });
  }

  AppToolBarsCompanion copyWith(
      {Value<int>? id,
      Value<ToolbarButtons>? toolbarEnum,
      Value<int>? order,
      Value<bool>? enable}) {
    return AppToolBarsCompanion(
      id: id ?? this.id,
      toolbarEnum: toolbarEnum ?? this.toolbarEnum,
      order: order ?? this.order,
      enable: enable ?? this.enable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (toolbarEnum.present) {
      final converter = $AppToolBarsTable.$convertertoolbarEnum;
      map['toolbar_enum'] =
          Variable<String>(converter.toSql(toolbarEnum.value));
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppToolBarsCompanion(')
          ..write('id: $id, ')
          ..write('toolbarEnum: $toolbarEnum, ')
          ..write('order: $order, ')
          ..write('enable: $enable')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumnWithTypeConverter<SettingEnums, String> key =
      GeneratedColumn<String>('key', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SettingEnums>($SettingsTable.$converterkey);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? 'settings';
  @override
  String get actualTableName => 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_keyMeta, const VerificationResult.success());
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: $SettingsTable.$converterkey.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SettingEnums, String, String> $converterkey =
      const EnumNameConverter<SettingEnums>(SettingEnums.values);
}

class Setting extends DataClass implements Insertable<Setting> {
  final SettingEnums key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = $SettingsTable.$converterkey;
      map['key'] = Variable<String>(converter.toSql(key));
    }
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: $SettingsTable.$converterkey
          .fromJson(serializer.fromJson<String>(json['key'])),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key':
          serializer.toJson<String>($SettingsTable.$converterkey.toJson(key)),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({SettingEnums? key, String? value}) => Setting(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<SettingEnums> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required SettingEnums key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<SettingEnums>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      final converter = $SettingsTable.$converterkey;
      map['key'] = Variable<String>(converter.toSql(key.value));
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  late final $NotesTable notes = $NotesTable(this);
  late final $AppToolBarsTable appToolBars = $AppToolBarsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [notes, appToolBars, settings];
}
