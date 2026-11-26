// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GamesTable extends Games with TableInfo<$GamesTable, Game> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pgnMeta = const VerificationMeta('pgn');
  @override
  late final GeneratedColumn<String> pgn = GeneratedColumn<String>(
    'pgn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _whiteMeta = const VerificationMeta('white');
  @override
  late final GeneratedColumn<String> white = GeneratedColumn<String>(
    'white',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blackMeta = const VerificationMeta('black');
  @override
  late final GeneratedColumn<String> black = GeneratedColumn<String>(
    'black',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeControlMeta = const VerificationMeta(
    'timeControl',
  );
  @override
  late final GeneratedColumn<String> timeControl = GeneratedColumn<String>(
    'time_control',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userSideMeta = const VerificationMeta(
    'userSide',
  );
  @override
  late final GeneratedColumn<String> userSide = GeneratedColumn<String>(
    'user_side',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ecoMeta = const VerificationMeta('eco');
  @override
  late final GeneratedColumn<String> eco = GeneratedColumn<String>(
    'eco',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openingNameMeta = const VerificationMeta(
    'openingName',
  );
  @override
  late final GeneratedColumn<String> openingName = GeneratedColumn<String>(
    'opening_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pliesMeta = const VerificationMeta('plies');
  @override
  late final GeneratedColumn<int> plies = GeneratedColumn<int>(
    'plies',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    source,
    externalId,
    pgn,
    white,
    black,
    result,
    date,
    timeControl,
    userSide,
    eco,
    openingName,
    plies,
    createdAt,
    updatedAt,
    deleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'games';
  @override
  VerificationContext validateIntegrity(
    Insertable<Game> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('pgn')) {
      context.handle(
        _pgnMeta,
        pgn.isAcceptableOrUnknown(data['pgn']!, _pgnMeta),
      );
    } else if (isInserting) {
      context.missing(_pgnMeta);
    }
    if (data.containsKey('white')) {
      context.handle(
        _whiteMeta,
        white.isAcceptableOrUnknown(data['white']!, _whiteMeta),
      );
    } else if (isInserting) {
      context.missing(_whiteMeta);
    }
    if (data.containsKey('black')) {
      context.handle(
        _blackMeta,
        black.isAcceptableOrUnknown(data['black']!, _blackMeta),
      );
    } else if (isInserting) {
      context.missing(_blackMeta);
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('time_control')) {
      context.handle(
        _timeControlMeta,
        timeControl.isAcceptableOrUnknown(
          data['time_control']!,
          _timeControlMeta,
        ),
      );
    }
    if (data.containsKey('user_side')) {
      context.handle(
        _userSideMeta,
        userSide.isAcceptableOrUnknown(data['user_side']!, _userSideMeta),
      );
    }
    if (data.containsKey('eco')) {
      context.handle(
        _ecoMeta,
        eco.isAcceptableOrUnknown(data['eco']!, _ecoMeta),
      );
    }
    if (data.containsKey('opening_name')) {
      context.handle(
        _openingNameMeta,
        openingName.isAcceptableOrUnknown(
          data['opening_name']!,
          _openingNameMeta,
        ),
      );
    }
    if (data.containsKey('plies')) {
      context.handle(
        _pliesMeta,
        plies.isAcceptableOrUnknown(data['plies']!, _pliesMeta),
      );
    } else if (isInserting) {
      context.missing(_pliesMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {source, externalId},
  ];
  @override
  Game map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Game(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      pgn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pgn'],
      )!,
      white: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}white'],
      )!,
      black: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}black'],
      )!,
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      ),
      timeControl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_control'],
      ),
      userSide: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_side'],
      ),
      eco: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}eco'],
      ),
      openingName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_name'],
      ),
      plies: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plies'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
    );
  }

  @override
  $GamesTable createAlias(String alias) {
    return $GamesTable(attachedDatabase, alias);
  }
}

class Game extends DataClass implements Insertable<Game> {
  final int id;
  final String source;
  final String? externalId;
  final String pgn;
  final String white;
  final String black;
  final String result;
  final String? date;
  final String? timeControl;
  final String? userSide;
  final String? eco;
  final String? openingName;
  final int plies;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool deleted;
  const Game({
    required this.id,
    required this.source,
    this.externalId,
    required this.pgn,
    required this.white,
    required this.black,
    required this.result,
    this.date,
    this.timeControl,
    this.userSide,
    this.eco,
    this.openingName,
    required this.plies,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    map['pgn'] = Variable<String>(pgn);
    map['white'] = Variable<String>(white);
    map['black'] = Variable<String>(black);
    map['result'] = Variable<String>(result);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || timeControl != null) {
      map['time_control'] = Variable<String>(timeControl);
    }
    if (!nullToAbsent || userSide != null) {
      map['user_side'] = Variable<String>(userSide);
    }
    if (!nullToAbsent || eco != null) {
      map['eco'] = Variable<String>(eco);
    }
    if (!nullToAbsent || openingName != null) {
      map['opening_name'] = Variable<String>(openingName);
    }
    map['plies'] = Variable<int>(plies);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  GamesCompanion toCompanion(bool nullToAbsent) {
    return GamesCompanion(
      id: Value(id),
      source: Value(source),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      pgn: Value(pgn),
      white: Value(white),
      black: Value(black),
      result: Value(result),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      timeControl: timeControl == null && nullToAbsent
          ? const Value.absent()
          : Value(timeControl),
      userSide: userSide == null && nullToAbsent
          ? const Value.absent()
          : Value(userSide),
      eco: eco == null && nullToAbsent ? const Value.absent() : Value(eco),
      openingName: openingName == null && nullToAbsent
          ? const Value.absent()
          : Value(openingName),
      plies: Value(plies),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deleted: Value(deleted),
    );
  }

  factory Game.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Game(
      id: serializer.fromJson<int>(json['id']),
      source: serializer.fromJson<String>(json['source']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      pgn: serializer.fromJson<String>(json['pgn']),
      white: serializer.fromJson<String>(json['white']),
      black: serializer.fromJson<String>(json['black']),
      result: serializer.fromJson<String>(json['result']),
      date: serializer.fromJson<String?>(json['date']),
      timeControl: serializer.fromJson<String?>(json['timeControl']),
      userSide: serializer.fromJson<String?>(json['userSide']),
      eco: serializer.fromJson<String?>(json['eco']),
      openingName: serializer.fromJson<String?>(json['openingName']),
      plies: serializer.fromJson<int>(json['plies']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'source': serializer.toJson<String>(source),
      'externalId': serializer.toJson<String?>(externalId),
      'pgn': serializer.toJson<String>(pgn),
      'white': serializer.toJson<String>(white),
      'black': serializer.toJson<String>(black),
      'result': serializer.toJson<String>(result),
      'date': serializer.toJson<String?>(date),
      'timeControl': serializer.toJson<String?>(timeControl),
      'userSide': serializer.toJson<String?>(userSide),
      'eco': serializer.toJson<String?>(eco),
      'openingName': serializer.toJson<String?>(openingName),
      'plies': serializer.toJson<int>(plies),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  Game copyWith({
    int? id,
    String? source,
    Value<String?> externalId = const Value.absent(),
    String? pgn,
    String? white,
    String? black,
    String? result,
    Value<String?> date = const Value.absent(),
    Value<String?> timeControl = const Value.absent(),
    Value<String?> userSide = const Value.absent(),
    Value<String?> eco = const Value.absent(),
    Value<String?> openingName = const Value.absent(),
    int? plies,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? deleted,
  }) => Game(
    id: id ?? this.id,
    source: source ?? this.source,
    externalId: externalId.present ? externalId.value : this.externalId,
    pgn: pgn ?? this.pgn,
    white: white ?? this.white,
    black: black ?? this.black,
    result: result ?? this.result,
    date: date.present ? date.value : this.date,
    timeControl: timeControl.present ? timeControl.value : this.timeControl,
    userSide: userSide.present ? userSide.value : this.userSide,
    eco: eco.present ? eco.value : this.eco,
    openingName: openingName.present ? openingName.value : this.openingName,
    plies: plies ?? this.plies,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deleted: deleted ?? this.deleted,
  );
  Game copyWithCompanion(GamesCompanion data) {
    return Game(
      id: data.id.present ? data.id.value : this.id,
      source: data.source.present ? data.source.value : this.source,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      pgn: data.pgn.present ? data.pgn.value : this.pgn,
      white: data.white.present ? data.white.value : this.white,
      black: data.black.present ? data.black.value : this.black,
      result: data.result.present ? data.result.value : this.result,
      date: data.date.present ? data.date.value : this.date,
      timeControl: data.timeControl.present
          ? data.timeControl.value
          : this.timeControl,
      userSide: data.userSide.present ? data.userSide.value : this.userSide,
      eco: data.eco.present ? data.eco.value : this.eco,
      openingName: data.openingName.present
          ? data.openingName.value
          : this.openingName,
      plies: data.plies.present ? data.plies.value : this.plies,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Game(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('externalId: $externalId, ')
          ..write('pgn: $pgn, ')
          ..write('white: $white, ')
          ..write('black: $black, ')
          ..write('result: $result, ')
          ..write('date: $date, ')
          ..write('timeControl: $timeControl, ')
          ..write('userSide: $userSide, ')
          ..write('eco: $eco, ')
          ..write('openingName: $openingName, ')
          ..write('plies: $plies, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    source,
    externalId,
    pgn,
    white,
    black,
    result,
    date,
    timeControl,
    userSide,
    eco,
    openingName,
    plies,
    createdAt,
    updatedAt,
    deleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Game &&
          other.id == this.id &&
          other.source == this.source &&
          other.externalId == this.externalId &&
          other.pgn == this.pgn &&
          other.white == this.white &&
          other.black == this.black &&
          other.result == this.result &&
          other.date == this.date &&
          other.timeControl == this.timeControl &&
          other.userSide == this.userSide &&
          other.eco == this.eco &&
          other.openingName == this.openingName &&
          other.plies == this.plies &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deleted == this.deleted);
}

class GamesCompanion extends UpdateCompanion<Game> {
  final Value<int> id;
  final Value<String> source;
  final Value<String?> externalId;
  final Value<String> pgn;
  final Value<String> white;
  final Value<String> black;
  final Value<String> result;
  final Value<String?> date;
  final Value<String?> timeControl;
  final Value<String?> userSide;
  final Value<String?> eco;
  final Value<String?> openingName;
  final Value<int> plies;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> deleted;
  const GamesCompanion({
    this.id = const Value.absent(),
    this.source = const Value.absent(),
    this.externalId = const Value.absent(),
    this.pgn = const Value.absent(),
    this.white = const Value.absent(),
    this.black = const Value.absent(),
    this.result = const Value.absent(),
    this.date = const Value.absent(),
    this.timeControl = const Value.absent(),
    this.userSide = const Value.absent(),
    this.eco = const Value.absent(),
    this.openingName = const Value.absent(),
    this.plies = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deleted = const Value.absent(),
  });
  GamesCompanion.insert({
    this.id = const Value.absent(),
    required String source,
    this.externalId = const Value.absent(),
    required String pgn,
    required String white,
    required String black,
    required String result,
    this.date = const Value.absent(),
    this.timeControl = const Value.absent(),
    this.userSide = const Value.absent(),
    this.eco = const Value.absent(),
    this.openingName = const Value.absent(),
    required int plies,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deleted = const Value.absent(),
  }) : source = Value(source),
       pgn = Value(pgn),
       white = Value(white),
       black = Value(black),
       result = Value(result),
       plies = Value(plies),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Game> custom({
    Expression<int>? id,
    Expression<String>? source,
    Expression<String>? externalId,
    Expression<String>? pgn,
    Expression<String>? white,
    Expression<String>? black,
    Expression<String>? result,
    Expression<String>? date,
    Expression<String>? timeControl,
    Expression<String>? userSide,
    Expression<String>? eco,
    Expression<String>? openingName,
    Expression<int>? plies,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? deleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (externalId != null) 'external_id': externalId,
      if (pgn != null) 'pgn': pgn,
      if (white != null) 'white': white,
      if (black != null) 'black': black,
      if (result != null) 'result': result,
      if (date != null) 'date': date,
      if (timeControl != null) 'time_control': timeControl,
      if (userSide != null) 'user_side': userSide,
      if (eco != null) 'eco': eco,
      if (openingName != null) 'opening_name': openingName,
      if (plies != null) 'plies': plies,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deleted != null) 'deleted': deleted,
    });
  }

  GamesCompanion copyWith({
    Value<int>? id,
    Value<String>? source,
    Value<String?>? externalId,
    Value<String>? pgn,
    Value<String>? white,
    Value<String>? black,
    Value<String>? result,
    Value<String?>? date,
    Value<String?>? timeControl,
    Value<String?>? userSide,
    Value<String?>? eco,
    Value<String?>? openingName,
    Value<int>? plies,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? deleted,
  }) {
    return GamesCompanion(
      id: id ?? this.id,
      source: source ?? this.source,
      externalId: externalId ?? this.externalId,
      pgn: pgn ?? this.pgn,
      white: white ?? this.white,
      black: black ?? this.black,
      result: result ?? this.result,
      date: date ?? this.date,
      timeControl: timeControl ?? this.timeControl,
      userSide: userSide ?? this.userSide,
      eco: eco ?? this.eco,
      openingName: openingName ?? this.openingName,
      plies: plies ?? this.plies,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (pgn.present) {
      map['pgn'] = Variable<String>(pgn.value);
    }
    if (white.present) {
      map['white'] = Variable<String>(white.value);
    }
    if (black.present) {
      map['black'] = Variable<String>(black.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (timeControl.present) {
      map['time_control'] = Variable<String>(timeControl.value);
    }
    if (userSide.present) {
      map['user_side'] = Variable<String>(userSide.value);
    }
    if (eco.present) {
      map['eco'] = Variable<String>(eco.value);
    }
    if (openingName.present) {
      map['opening_name'] = Variable<String>(openingName.value);
    }
    if (plies.present) {
      map['plies'] = Variable<int>(plies.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamesCompanion(')
          ..write('id: $id, ')
          ..write('source: $source, ')
          ..write('externalId: $externalId, ')
          ..write('pgn: $pgn, ')
          ..write('white: $white, ')
          ..write('black: $black, ')
          ..write('result: $result, ')
          ..write('date: $date, ')
          ..write('timeControl: $timeControl, ')
          ..write('userSide: $userSide, ')
          ..write('eco: $eco, ')
          ..write('openingName: $openingName, ')
          ..write('plies: $plies, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }
}

class $PositionEvalsTable extends PositionEvals
    with TableInfo<$PositionEvalsTable, PositionEval> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PositionEvalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _epdMeta = const VerificationMeta('epd');
  @override
  late final GeneratedColumn<String> epd = GeneratedColumn<String>(
    'epd',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineMeta = const VerificationMeta('engine');
  @override
  late final GeneratedColumn<String> engine = GeneratedColumn<String>(
    'engine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _presetMeta = const VerificationMeta('preset');
  @override
  late final GeneratedColumn<String> preset = GeneratedColumn<String>(
    'preset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linesMeta = const VerificationMeta('lines');
  @override
  late final GeneratedColumn<String> lines = GeneratedColumn<String>(
    'lines',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [epd, engine, preset, lines];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'position_evals';
  @override
  VerificationContext validateIntegrity(
    Insertable<PositionEval> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('epd')) {
      context.handle(
        _epdMeta,
        epd.isAcceptableOrUnknown(data['epd']!, _epdMeta),
      );
    } else if (isInserting) {
      context.missing(_epdMeta);
    }
    if (data.containsKey('engine')) {
      context.handle(
        _engineMeta,
        engine.isAcceptableOrUnknown(data['engine']!, _engineMeta),
      );
    } else if (isInserting) {
      context.missing(_engineMeta);
    }
    if (data.containsKey('preset')) {
      context.handle(
        _presetMeta,
        preset.isAcceptableOrUnknown(data['preset']!, _presetMeta),
      );
    } else if (isInserting) {
      context.missing(_presetMeta);
    }
    if (data.containsKey('lines')) {
      context.handle(
        _linesMeta,
        lines.isAcceptableOrUnknown(data['lines']!, _linesMeta),
      );
    } else if (isInserting) {
      context.missing(_linesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {epd, engine, preset};
  @override
  PositionEval map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PositionEval(
      epd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}epd'],
      )!,
      engine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine'],
      )!,
      preset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset'],
      )!,
      lines: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lines'],
      )!,
    );
  }

  @override
  $PositionEvalsTable createAlias(String alias) {
    return $PositionEvalsTable(attachedDatabase, alias);
  }
}

class PositionEval extends DataClass implements Insertable<PositionEval> {
  final String epd;
  final String engine;
  final String preset;
  final String lines;
  const PositionEval({
    required this.epd,
    required this.engine,
    required this.preset,
    required this.lines,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['epd'] = Variable<String>(epd);
    map['engine'] = Variable<String>(engine);
    map['preset'] = Variable<String>(preset);
    map['lines'] = Variable<String>(lines);
    return map;
  }

  PositionEvalsCompanion toCompanion(bool nullToAbsent) {
    return PositionEvalsCompanion(
      epd: Value(epd),
      engine: Value(engine),
      preset: Value(preset),
      lines: Value(lines),
    );
  }

  factory PositionEval.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PositionEval(
      epd: serializer.fromJson<String>(json['epd']),
      engine: serializer.fromJson<String>(json['engine']),
      preset: serializer.fromJson<String>(json['preset']),
      lines: serializer.fromJson<String>(json['lines']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'epd': serializer.toJson<String>(epd),
      'engine': serializer.toJson<String>(engine),
      'preset': serializer.toJson<String>(preset),
      'lines': serializer.toJson<String>(lines),
    };
  }

  PositionEval copyWith({
    String? epd,
    String? engine,
    String? preset,
    String? lines,
  }) => PositionEval(
    epd: epd ?? this.epd,
    engine: engine ?? this.engine,
    preset: preset ?? this.preset,
    lines: lines ?? this.lines,
  );
  PositionEval copyWithCompanion(PositionEvalsCompanion data) {
    return PositionEval(
      epd: data.epd.present ? data.epd.value : this.epd,
      engine: data.engine.present ? data.engine.value : this.engine,
      preset: data.preset.present ? data.preset.value : this.preset,
      lines: data.lines.present ? data.lines.value : this.lines,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PositionEval(')
          ..write('epd: $epd, ')
          ..write('engine: $engine, ')
          ..write('preset: $preset, ')
          ..write('lines: $lines')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(epd, engine, preset, lines);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PositionEval &&
          other.epd == this.epd &&
          other.engine == this.engine &&
          other.preset == this.preset &&
          other.lines == this.lines);
}

class PositionEvalsCompanion extends UpdateCompanion<PositionEval> {
  final Value<String> epd;
  final Value<String> engine;
  final Value<String> preset;
  final Value<String> lines;
  final Value<int> rowid;
  const PositionEvalsCompanion({
    this.epd = const Value.absent(),
    this.engine = const Value.absent(),
    this.preset = const Value.absent(),
    this.lines = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PositionEvalsCompanion.insert({
    required String epd,
    required String engine,
    required String preset,
    required String lines,
    this.rowid = const Value.absent(),
  }) : epd = Value(epd),
       engine = Value(engine),
       preset = Value(preset),
       lines = Value(lines);
  static Insertable<PositionEval> custom({
    Expression<String>? epd,
    Expression<String>? engine,
    Expression<String>? preset,
    Expression<String>? lines,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (epd != null) 'epd': epd,
      if (engine != null) 'engine': engine,
      if (preset != null) 'preset': preset,
      if (lines != null) 'lines': lines,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PositionEvalsCompanion copyWith({
    Value<String>? epd,
    Value<String>? engine,
    Value<String>? preset,
    Value<String>? lines,
    Value<int>? rowid,
  }) {
    return PositionEvalsCompanion(
      epd: epd ?? this.epd,
      engine: engine ?? this.engine,
      preset: preset ?? this.preset,
      lines: lines ?? this.lines,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (epd.present) {
      map['epd'] = Variable<String>(epd.value);
    }
    if (engine.present) {
      map['engine'] = Variable<String>(engine.value);
    }
    if (preset.present) {
      map['preset'] = Variable<String>(preset.value);
    }
    if (lines.present) {
      map['lines'] = Variable<String>(lines.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PositionEvalsCompanion(')
          ..write('epd: $epd, ')
          ..write('engine: $engine, ')
          ..write('preset: $preset, ')
          ..write('lines: $lines, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameAnalysesTable extends GameAnalyses
    with TableInfo<$GameAnalysesTable, GameAnalyse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameAnalysesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES games (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _engineMeta = const VerificationMeta('engine');
  @override
  late final GeneratedColumn<String> engine = GeneratedColumn<String>(
    'engine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _presetMeta = const VerificationMeta('preset');
  @override
  late final GeneratedColumn<String> preset = GeneratedColumn<String>(
    'preset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyWhiteMeta = const VerificationMeta(
    'accuracyWhite',
  );
  @override
  late final GeneratedColumn<double> accuracyWhite = GeneratedColumn<double>(
    'accuracy_white',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyBlackMeta = const VerificationMeta(
    'accuracyBlack',
  );
  @override
  late final GeneratedColumn<double> accuracyBlack = GeneratedColumn<double>(
    'accuracy_black',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userAccuracyMeta = const VerificationMeta(
    'userAccuracy',
  );
  @override
  late final GeneratedColumn<double> userAccuracy = GeneratedColumn<double>(
    'user_accuracy',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userInaccuraciesMeta = const VerificationMeta(
    'userInaccuracies',
  );
  @override
  late final GeneratedColumn<int> userInaccuracies = GeneratedColumn<int>(
    'user_inaccuracies',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _userMistakesMeta = const VerificationMeta(
    'userMistakes',
  );
  @override
  late final GeneratedColumn<int> userMistakes = GeneratedColumn<int>(
    'user_mistakes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _userBlundersMeta = const VerificationMeta(
    'userBlunders',
  );
  @override
  late final GeneratedColumn<int> userBlunders = GeneratedColumn<int>(
    'user_blunders',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reportMeta = const VerificationMeta('report');
  @override
  late final GeneratedColumn<String> report = GeneratedColumn<String>(
    'report',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    gameId,
    engine,
    preset,
    accuracyWhite,
    accuracyBlack,
    userAccuracy,
    userInaccuracies,
    userMistakes,
    userBlunders,
    report,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_analyses';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameAnalyse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    }
    if (data.containsKey('engine')) {
      context.handle(
        _engineMeta,
        engine.isAcceptableOrUnknown(data['engine']!, _engineMeta),
      );
    } else if (isInserting) {
      context.missing(_engineMeta);
    }
    if (data.containsKey('preset')) {
      context.handle(
        _presetMeta,
        preset.isAcceptableOrUnknown(data['preset']!, _presetMeta),
      );
    } else if (isInserting) {
      context.missing(_presetMeta);
    }
    if (data.containsKey('accuracy_white')) {
      context.handle(
        _accuracyWhiteMeta,
        accuracyWhite.isAcceptableOrUnknown(
          data['accuracy_white']!,
          _accuracyWhiteMeta,
        ),
      );
    }
    if (data.containsKey('accuracy_black')) {
      context.handle(
        _accuracyBlackMeta,
        accuracyBlack.isAcceptableOrUnknown(
          data['accuracy_black']!,
          _accuracyBlackMeta,
        ),
      );
    }
    if (data.containsKey('user_accuracy')) {
      context.handle(
        _userAccuracyMeta,
        userAccuracy.isAcceptableOrUnknown(
          data['user_accuracy']!,
          _userAccuracyMeta,
        ),
      );
    }
    if (data.containsKey('user_inaccuracies')) {
      context.handle(
        _userInaccuraciesMeta,
        userInaccuracies.isAcceptableOrUnknown(
          data['user_inaccuracies']!,
          _userInaccuraciesMeta,
        ),
      );
    }
    if (data.containsKey('user_mistakes')) {
      context.handle(
        _userMistakesMeta,
        userMistakes.isAcceptableOrUnknown(
          data['user_mistakes']!,
          _userMistakesMeta,
        ),
      );
    }
    if (data.containsKey('user_blunders')) {
      context.handle(
        _userBlundersMeta,
        userBlunders.isAcceptableOrUnknown(
          data['user_blunders']!,
          _userBlundersMeta,
        ),
      );
    }
    if (data.containsKey('report')) {
      context.handle(
        _reportMeta,
        report.isAcceptableOrUnknown(data['report']!, _reportMeta),
      );
    } else if (isInserting) {
      context.missing(_reportMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gameId};
  @override
  GameAnalyse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameAnalyse(
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}game_id'],
      )!,
      engine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine'],
      )!,
      preset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset'],
      )!,
      accuracyWhite: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_white'],
      ),
      accuracyBlack: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_black'],
      ),
      userAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}user_accuracy'],
      ),
      userInaccuracies: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_inaccuracies'],
      )!,
      userMistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_mistakes'],
      )!,
      userBlunders: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_blunders'],
      )!,
      report: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GameAnalysesTable createAlias(String alias) {
    return $GameAnalysesTable(attachedDatabase, alias);
  }
}

class GameAnalyse extends DataClass implements Insertable<GameAnalyse> {
  final int gameId;
  final String engine;
  final String preset;
  final double? accuracyWhite;
  final double? accuracyBlack;
  final double? userAccuracy;
  final int userInaccuracies;
  final int userMistakes;
  final int userBlunders;
  final String report;
  final DateTime createdAt;
  const GameAnalyse({
    required this.gameId,
    required this.engine,
    required this.preset,
    this.accuracyWhite,
    this.accuracyBlack,
    this.userAccuracy,
    required this.userInaccuracies,
    required this.userMistakes,
    required this.userBlunders,
    required this.report,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['game_id'] = Variable<int>(gameId);
    map['engine'] = Variable<String>(engine);
    map['preset'] = Variable<String>(preset);
    if (!nullToAbsent || accuracyWhite != null) {
      map['accuracy_white'] = Variable<double>(accuracyWhite);
    }
    if (!nullToAbsent || accuracyBlack != null) {
      map['accuracy_black'] = Variable<double>(accuracyBlack);
    }
    if (!nullToAbsent || userAccuracy != null) {
      map['user_accuracy'] = Variable<double>(userAccuracy);
    }
    map['user_inaccuracies'] = Variable<int>(userInaccuracies);
    map['user_mistakes'] = Variable<int>(userMistakes);
    map['user_blunders'] = Variable<int>(userBlunders);
    map['report'] = Variable<String>(report);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GameAnalysesCompanion toCompanion(bool nullToAbsent) {
    return GameAnalysesCompanion(
      gameId: Value(gameId),
      engine: Value(engine),
      preset: Value(preset),
      accuracyWhite: accuracyWhite == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyWhite),
      accuracyBlack: accuracyBlack == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyBlack),
      userAccuracy: userAccuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(userAccuracy),
      userInaccuracies: Value(userInaccuracies),
      userMistakes: Value(userMistakes),
      userBlunders: Value(userBlunders),
      report: Value(report),
      createdAt: Value(createdAt),
    );
  }

  factory GameAnalyse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameAnalyse(
      gameId: serializer.fromJson<int>(json['gameId']),
      engine: serializer.fromJson<String>(json['engine']),
      preset: serializer.fromJson<String>(json['preset']),
      accuracyWhite: serializer.fromJson<double?>(json['accuracyWhite']),
      accuracyBlack: serializer.fromJson<double?>(json['accuracyBlack']),
      userAccuracy: serializer.fromJson<double?>(json['userAccuracy']),
      userInaccuracies: serializer.fromJson<int>(json['userInaccuracies']),
      userMistakes: serializer.fromJson<int>(json['userMistakes']),
      userBlunders: serializer.fromJson<int>(json['userBlunders']),
      report: serializer.fromJson<String>(json['report']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gameId': serializer.toJson<int>(gameId),
      'engine': serializer.toJson<String>(engine),
      'preset': serializer.toJson<String>(preset),
      'accuracyWhite': serializer.toJson<double?>(accuracyWhite),
      'accuracyBlack': serializer.toJson<double?>(accuracyBlack),
      'userAccuracy': serializer.toJson<double?>(userAccuracy),
      'userInaccuracies': serializer.toJson<int>(userInaccuracies),
      'userMistakes': serializer.toJson<int>(userMistakes),
      'userBlunders': serializer.toJson<int>(userBlunders),
      'report': serializer.toJson<String>(report),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GameAnalyse copyWith({
    int? gameId,
    String? engine,
    String? preset,
    Value<double?> accuracyWhite = const Value.absent(),
    Value<double?> accuracyBlack = const Value.absent(),
    Value<double?> userAccuracy = const Value.absent(),
    int? userInaccuracies,
    int? userMistakes,
    int? userBlunders,
    String? report,
    DateTime? createdAt,
  }) => GameAnalyse(
    gameId: gameId ?? this.gameId,
    engine: engine ?? this.engine,
    preset: preset ?? this.preset,
    accuracyWhite: accuracyWhite.present
        ? accuracyWhite.value
        : this.accuracyWhite,
    accuracyBlack: accuracyBlack.present
        ? accuracyBlack.value
        : this.accuracyBlack,
    userAccuracy: userAccuracy.present ? userAccuracy.value : this.userAccuracy,
    userInaccuracies: userInaccuracies ?? this.userInaccuracies,
    userMistakes: userMistakes ?? this.userMistakes,
    userBlunders: userBlunders ?? this.userBlunders,
    report: report ?? this.report,
    createdAt: createdAt ?? this.createdAt,
  );
  GameAnalyse copyWithCompanion(GameAnalysesCompanion data) {
    return GameAnalyse(
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      engine: data.engine.present ? data.engine.value : this.engine,
      preset: data.preset.present ? data.preset.value : this.preset,
      accuracyWhite: data.accuracyWhite.present
          ? data.accuracyWhite.value
          : this.accuracyWhite,
      accuracyBlack: data.accuracyBlack.present
          ? data.accuracyBlack.value
          : this.accuracyBlack,
      userAccuracy: data.userAccuracy.present
          ? data.userAccuracy.value
          : this.userAccuracy,
      userInaccuracies: data.userInaccuracies.present
          ? data.userInaccuracies.value
          : this.userInaccuracies,
      userMistakes: data.userMistakes.present
          ? data.userMistakes.value
          : this.userMistakes,
      userBlunders: data.userBlunders.present
          ? data.userBlunders.value
          : this.userBlunders,
      report: data.report.present ? data.report.value : this.report,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameAnalyse(')
          ..write('gameId: $gameId, ')
          ..write('engine: $engine, ')
          ..write('preset: $preset, ')
          ..write('accuracyWhite: $accuracyWhite, ')
          ..write('accuracyBlack: $accuracyBlack, ')
          ..write('userAccuracy: $userAccuracy, ')
          ..write('userInaccuracies: $userInaccuracies, ')
          ..write('userMistakes: $userMistakes, ')
          ..write('userBlunders: $userBlunders, ')
          ..write('report: $report, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    gameId,
    engine,
    preset,
    accuracyWhite,
    accuracyBlack,
    userAccuracy,
    userInaccuracies,
    userMistakes,
    userBlunders,
    report,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameAnalyse &&
          other.gameId == this.gameId &&
          other.engine == this.engine &&
          other.preset == this.preset &&
          other.accuracyWhite == this.accuracyWhite &&
          other.accuracyBlack == this.accuracyBlack &&
          other.userAccuracy == this.userAccuracy &&
          other.userInaccuracies == this.userInaccuracies &&
          other.userMistakes == this.userMistakes &&
          other.userBlunders == this.userBlunders &&
          other.report == this.report &&
          other.createdAt == this.createdAt);
}

class GameAnalysesCompanion extends UpdateCompanion<GameAnalyse> {
  final Value<int> gameId;
  final Value<String> engine;
  final Value<String> preset;
  final Value<double?> accuracyWhite;
  final Value<double?> accuracyBlack;
  final Value<double?> userAccuracy;
  final Value<int> userInaccuracies;
  final Value<int> userMistakes;
  final Value<int> userBlunders;
  final Value<String> report;
  final Value<DateTime> createdAt;
  const GameAnalysesCompanion({
    this.gameId = const Value.absent(),
    this.engine = const Value.absent(),
    this.preset = const Value.absent(),
    this.accuracyWhite = const Value.absent(),
    this.accuracyBlack = const Value.absent(),
    this.userAccuracy = const Value.absent(),
    this.userInaccuracies = const Value.absent(),
    this.userMistakes = const Value.absent(),
    this.userBlunders = const Value.absent(),
    this.report = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GameAnalysesCompanion.insert({
    this.gameId = const Value.absent(),
    required String engine,
    required String preset,
    this.accuracyWhite = const Value.absent(),
    this.accuracyBlack = const Value.absent(),
    this.userAccuracy = const Value.absent(),
    this.userInaccuracies = const Value.absent(),
    this.userMistakes = const Value.absent(),
    this.userBlunders = const Value.absent(),
    required String report,
    required DateTime createdAt,
  }) : engine = Value(engine),
       preset = Value(preset),
       report = Value(report),
       createdAt = Value(createdAt);
  static Insertable<GameAnalyse> custom({
    Expression<int>? gameId,
    Expression<String>? engine,
    Expression<String>? preset,
    Expression<double>? accuracyWhite,
    Expression<double>? accuracyBlack,
    Expression<double>? userAccuracy,
    Expression<int>? userInaccuracies,
    Expression<int>? userMistakes,
    Expression<int>? userBlunders,
    Expression<String>? report,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (gameId != null) 'game_id': gameId,
      if (engine != null) 'engine': engine,
      if (preset != null) 'preset': preset,
      if (accuracyWhite != null) 'accuracy_white': accuracyWhite,
      if (accuracyBlack != null) 'accuracy_black': accuracyBlack,
      if (userAccuracy != null) 'user_accuracy': userAccuracy,
      if (userInaccuracies != null) 'user_inaccuracies': userInaccuracies,
      if (userMistakes != null) 'user_mistakes': userMistakes,
      if (userBlunders != null) 'user_blunders': userBlunders,
      if (report != null) 'report': report,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GameAnalysesCompanion copyWith({
    Value<int>? gameId,
    Value<String>? engine,
    Value<String>? preset,
    Value<double?>? accuracyWhite,
    Value<double?>? accuracyBlack,
    Value<double?>? userAccuracy,
    Value<int>? userInaccuracies,
    Value<int>? userMistakes,
    Value<int>? userBlunders,
    Value<String>? report,
    Value<DateTime>? createdAt,
  }) {
    return GameAnalysesCompanion(
      gameId: gameId ?? this.gameId,
      engine: engine ?? this.engine,
      preset: preset ?? this.preset,
      accuracyWhite: accuracyWhite ?? this.accuracyWhite,
      accuracyBlack: accuracyBlack ?? this.accuracyBlack,
      userAccuracy: userAccuracy ?? this.userAccuracy,
      userInaccuracies: userInaccuracies ?? this.userInaccuracies,
      userMistakes: userMistakes ?? this.userMistakes,
      userBlunders: userBlunders ?? this.userBlunders,
      report: report ?? this.report,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    if (engine.present) {
      map['engine'] = Variable<String>(engine.value);
    }
    if (preset.present) {
      map['preset'] = Variable<String>(preset.value);
    }
    if (accuracyWhite.present) {
      map['accuracy_white'] = Variable<double>(accuracyWhite.value);
    }
    if (accuracyBlack.present) {
      map['accuracy_black'] = Variable<double>(accuracyBlack.value);
    }
    if (userAccuracy.present) {
      map['user_accuracy'] = Variable<double>(userAccuracy.value);
    }
    if (userInaccuracies.present) {
      map['user_inaccuracies'] = Variable<int>(userInaccuracies.value);
    }
    if (userMistakes.present) {
      map['user_mistakes'] = Variable<int>(userMistakes.value);
    }
    if (userBlunders.present) {
      map['user_blunders'] = Variable<int>(userBlunders.value);
    }
    if (report.present) {
      map['report'] = Variable<String>(report.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameAnalysesCompanion(')
          ..write('gameId: $gameId, ')
          ..write('engine: $engine, ')
          ..write('preset: $preset, ')
          ..write('accuracyWhite: $accuracyWhite, ')
          ..write('accuracyBlack: $accuracyBlack, ')
          ..write('userAccuracy: $userAccuracy, ')
          ..write('userInaccuracies: $userInaccuracies, ')
          ..write('userMistakes: $userMistakes, ')
          ..write('userBlunders: $userBlunders, ')
          ..write('report: $report, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PuzzlesTable extends Puzzles with TableInfo<$PuzzlesTable, PuzzleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PuzzlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fenMeta = const VerificationMeta('fen');
  @override
  late final GeneratedColumn<String> fen = GeneratedColumn<String>(
    'fen',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movesMeta = const VerificationMeta('moves');
  @override
  late final GeneratedColumn<String> moves = GeneratedColumn<String>(
    'moves',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _popularityMeta = const VerificationMeta(
    'popularity',
  );
  @override
  late final GeneratedColumn<int> popularity = GeneratedColumn<int>(
    'popularity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _themesMeta = const VerificationMeta('themes');
  @override
  late final GeneratedColumn<String> themes = GeneratedColumn<String>(
    'themes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<String> packId = GeneratedColumn<String>(
    'pack_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<int> gameId = GeneratedColumn<int>(
    'game_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plyMeta = const VerificationMeta('ply');
  @override
  late final GeneratedColumn<int> ply = GeneratedColumn<int>(
    'ply',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fen,
    moves,
    rating,
    popularity,
    themes,
    source,
    packId,
    gameId,
    ply,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'puzzles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PuzzleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fen')) {
      context.handle(
        _fenMeta,
        fen.isAcceptableOrUnknown(data['fen']!, _fenMeta),
      );
    } else if (isInserting) {
      context.missing(_fenMeta);
    }
    if (data.containsKey('moves')) {
      context.handle(
        _movesMeta,
        moves.isAcceptableOrUnknown(data['moves']!, _movesMeta),
      );
    } else if (isInserting) {
      context.missing(_movesMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('popularity')) {
      context.handle(
        _popularityMeta,
        popularity.isAcceptableOrUnknown(data['popularity']!, _popularityMeta),
      );
    }
    if (data.containsKey('themes')) {
      context.handle(
        _themesMeta,
        themes.isAcceptableOrUnknown(data['themes']!, _themesMeta),
      );
    } else if (isInserting) {
      context.missing(_themesMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('pack_id')) {
      context.handle(
        _packIdMeta,
        packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta),
      );
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    }
    if (data.containsKey('ply')) {
      context.handle(
        _plyMeta,
        ply.isAcceptableOrUnknown(data['ply']!, _plyMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PuzzleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PuzzleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fen'],
      )!,
      moves: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}moves'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      popularity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}popularity'],
      )!,
      themes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}themes'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_id'],
      ),
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}game_id'],
      ),
      ply: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ply'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PuzzlesTable createAlias(String alias) {
    return $PuzzlesTable(attachedDatabase, alias);
  }
}

class PuzzleRow extends DataClass implements Insertable<PuzzleRow> {
  final String id;
  final String fen;
  final String moves;
  final int rating;
  final int popularity;
  final String themes;
  final String source;
  final String? packId;
  final int? gameId;
  final int? ply;
  final String? note;
  const PuzzleRow({
    required this.id,
    required this.fen,
    required this.moves,
    required this.rating,
    required this.popularity,
    required this.themes,
    required this.source,
    this.packId,
    this.gameId,
    this.ply,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fen'] = Variable<String>(fen);
    map['moves'] = Variable<String>(moves);
    map['rating'] = Variable<int>(rating);
    map['popularity'] = Variable<int>(popularity);
    map['themes'] = Variable<String>(themes);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || packId != null) {
      map['pack_id'] = Variable<String>(packId);
    }
    if (!nullToAbsent || gameId != null) {
      map['game_id'] = Variable<int>(gameId);
    }
    if (!nullToAbsent || ply != null) {
      map['ply'] = Variable<int>(ply);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PuzzlesCompanion toCompanion(bool nullToAbsent) {
    return PuzzlesCompanion(
      id: Value(id),
      fen: Value(fen),
      moves: Value(moves),
      rating: Value(rating),
      popularity: Value(popularity),
      themes: Value(themes),
      source: Value(source),
      packId: packId == null && nullToAbsent
          ? const Value.absent()
          : Value(packId),
      gameId: gameId == null && nullToAbsent
          ? const Value.absent()
          : Value(gameId),
      ply: ply == null && nullToAbsent ? const Value.absent() : Value(ply),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PuzzleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PuzzleRow(
      id: serializer.fromJson<String>(json['id']),
      fen: serializer.fromJson<String>(json['fen']),
      moves: serializer.fromJson<String>(json['moves']),
      rating: serializer.fromJson<int>(json['rating']),
      popularity: serializer.fromJson<int>(json['popularity']),
      themes: serializer.fromJson<String>(json['themes']),
      source: serializer.fromJson<String>(json['source']),
      packId: serializer.fromJson<String?>(json['packId']),
      gameId: serializer.fromJson<int?>(json['gameId']),
      ply: serializer.fromJson<int?>(json['ply']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fen': serializer.toJson<String>(fen),
      'moves': serializer.toJson<String>(moves),
      'rating': serializer.toJson<int>(rating),
      'popularity': serializer.toJson<int>(popularity),
      'themes': serializer.toJson<String>(themes),
      'source': serializer.toJson<String>(source),
      'packId': serializer.toJson<String?>(packId),
      'gameId': serializer.toJson<int?>(gameId),
      'ply': serializer.toJson<int?>(ply),
      'note': serializer.toJson<String?>(note),
    };
  }

  PuzzleRow copyWith({
    String? id,
    String? fen,
    String? moves,
    int? rating,
    int? popularity,
    String? themes,
    String? source,
    Value<String?> packId = const Value.absent(),
    Value<int?> gameId = const Value.absent(),
    Value<int?> ply = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => PuzzleRow(
    id: id ?? this.id,
    fen: fen ?? this.fen,
    moves: moves ?? this.moves,
    rating: rating ?? this.rating,
    popularity: popularity ?? this.popularity,
    themes: themes ?? this.themes,
    source: source ?? this.source,
    packId: packId.present ? packId.value : this.packId,
    gameId: gameId.present ? gameId.value : this.gameId,
    ply: ply.present ? ply.value : this.ply,
    note: note.present ? note.value : this.note,
  );
  PuzzleRow copyWithCompanion(PuzzlesCompanion data) {
    return PuzzleRow(
      id: data.id.present ? data.id.value : this.id,
      fen: data.fen.present ? data.fen.value : this.fen,
      moves: data.moves.present ? data.moves.value : this.moves,
      rating: data.rating.present ? data.rating.value : this.rating,
      popularity: data.popularity.present
          ? data.popularity.value
          : this.popularity,
      themes: data.themes.present ? data.themes.value : this.themes,
      source: data.source.present ? data.source.value : this.source,
      packId: data.packId.present ? data.packId.value : this.packId,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      ply: data.ply.present ? data.ply.value : this.ply,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PuzzleRow(')
          ..write('id: $id, ')
          ..write('fen: $fen, ')
          ..write('moves: $moves, ')
          ..write('rating: $rating, ')
          ..write('popularity: $popularity, ')
          ..write('themes: $themes, ')
          ..write('source: $source, ')
          ..write('packId: $packId, ')
          ..write('gameId: $gameId, ')
          ..write('ply: $ply, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fen,
    moves,
    rating,
    popularity,
    themes,
    source,
    packId,
    gameId,
    ply,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PuzzleRow &&
          other.id == this.id &&
          other.fen == this.fen &&
          other.moves == this.moves &&
          other.rating == this.rating &&
          other.popularity == this.popularity &&
          other.themes == this.themes &&
          other.source == this.source &&
          other.packId == this.packId &&
          other.gameId == this.gameId &&
          other.ply == this.ply &&
          other.note == this.note);
}

class PuzzlesCompanion extends UpdateCompanion<PuzzleRow> {
  final Value<String> id;
  final Value<String> fen;
  final Value<String> moves;
  final Value<int> rating;
  final Value<int> popularity;
  final Value<String> themes;
  final Value<String> source;
  final Value<String?> packId;
  final Value<int?> gameId;
  final Value<int?> ply;
  final Value<String?> note;
  final Value<int> rowid;
  const PuzzlesCompanion({
    this.id = const Value.absent(),
    this.fen = const Value.absent(),
    this.moves = const Value.absent(),
    this.rating = const Value.absent(),
    this.popularity = const Value.absent(),
    this.themes = const Value.absent(),
    this.source = const Value.absent(),
    this.packId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.ply = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PuzzlesCompanion.insert({
    required String id,
    required String fen,
    required String moves,
    required int rating,
    this.popularity = const Value.absent(),
    required String themes,
    required String source,
    this.packId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.ply = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fen = Value(fen),
       moves = Value(moves),
       rating = Value(rating),
       themes = Value(themes),
       source = Value(source);
  static Insertable<PuzzleRow> custom({
    Expression<String>? id,
    Expression<String>? fen,
    Expression<String>? moves,
    Expression<int>? rating,
    Expression<int>? popularity,
    Expression<String>? themes,
    Expression<String>? source,
    Expression<String>? packId,
    Expression<int>? gameId,
    Expression<int>? ply,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fen != null) 'fen': fen,
      if (moves != null) 'moves': moves,
      if (rating != null) 'rating': rating,
      if (popularity != null) 'popularity': popularity,
      if (themes != null) 'themes': themes,
      if (source != null) 'source': source,
      if (packId != null) 'pack_id': packId,
      if (gameId != null) 'game_id': gameId,
      if (ply != null) 'ply': ply,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PuzzlesCompanion copyWith({
    Value<String>? id,
    Value<String>? fen,
    Value<String>? moves,
    Value<int>? rating,
    Value<int>? popularity,
    Value<String>? themes,
    Value<String>? source,
    Value<String?>? packId,
    Value<int?>? gameId,
    Value<int?>? ply,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return PuzzlesCompanion(
      id: id ?? this.id,
      fen: fen ?? this.fen,
      moves: moves ?? this.moves,
      rating: rating ?? this.rating,
      popularity: popularity ?? this.popularity,
      themes: themes ?? this.themes,
      source: source ?? this.source,
      packId: packId ?? this.packId,
      gameId: gameId ?? this.gameId,
      ply: ply ?? this.ply,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fen.present) {
      map['fen'] = Variable<String>(fen.value);
    }
    if (moves.present) {
      map['moves'] = Variable<String>(moves.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<int>(popularity.value);
    }
    if (themes.present) {
      map['themes'] = Variable<String>(themes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<String>(packId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<int>(gameId.value);
    }
    if (ply.present) {
      map['ply'] = Variable<int>(ply.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PuzzlesCompanion(')
          ..write('id: $id, ')
          ..write('fen: $fen, ')
          ..write('moves: $moves, ')
          ..write('rating: $rating, ')
          ..write('popularity: $popularity, ')
          ..write('themes: $themes, ')
          ..write('source: $source, ')
          ..write('packId: $packId, ')
          ..write('gameId: $gameId, ')
          ..write('ply: $ply, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PuzzlePacksTable extends PuzzlePacks
    with TableInfo<$PuzzlePacksTable, PuzzlePack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PuzzlePacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMinMeta = const VerificationMeta(
    'ratingMin',
  );
  @override
  late final GeneratedColumn<int> ratingMin = GeneratedColumn<int>(
    'rating_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMaxMeta = const VerificationMeta(
    'ratingMax',
  );
  @override
  late final GeneratedColumn<int> ratingMax = GeneratedColumn<int>(
    'rating_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bytesMeta = const VerificationMeta('bytes');
  @override
  late final GeneratedColumn<int> bytes = GeneratedColumn<int>(
    'bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _downloadedAtMeta = const VerificationMeta(
    'downloadedAt',
  );
  @override
  late final GeneratedColumn<DateTime> downloadedAt = GeneratedColumn<DateTime>(
    'downloaded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    theme,
    ratingMin,
    ratingMax,
    count,
    bytes,
    version,
    downloadedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'puzzle_packs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PuzzlePack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeMeta);
    }
    if (data.containsKey('rating_min')) {
      context.handle(
        _ratingMinMeta,
        ratingMin.isAcceptableOrUnknown(data['rating_min']!, _ratingMinMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMinMeta);
    }
    if (data.containsKey('rating_max')) {
      context.handle(
        _ratingMaxMeta,
        ratingMax.isAcceptableOrUnknown(data['rating_max']!, _ratingMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMaxMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('bytes')) {
      context.handle(
        _bytesMeta,
        bytes.isAcceptableOrUnknown(data['bytes']!, _bytesMeta),
      );
    } else if (isInserting) {
      context.missing(_bytesMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('downloaded_at')) {
      context.handle(
        _downloadedAtMeta,
        downloadedAt.isAcceptableOrUnknown(
          data['downloaded_at']!,
          _downloadedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_downloadedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PuzzlePack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PuzzlePack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      )!,
      ratingMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating_min'],
      )!,
      ratingMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating_max'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      bytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      downloadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}downloaded_at'],
      )!,
    );
  }

  @override
  $PuzzlePacksTable createAlias(String alias) {
    return $PuzzlePacksTable(attachedDatabase, alias);
  }
}

class PuzzlePack extends DataClass implements Insertable<PuzzlePack> {
  final String id;
  final String theme;
  final int ratingMin;
  final int ratingMax;
  final int count;
  final int bytes;
  final int version;
  final DateTime downloadedAt;
  const PuzzlePack({
    required this.id,
    required this.theme,
    required this.ratingMin,
    required this.ratingMax,
    required this.count,
    required this.bytes,
    required this.version,
    required this.downloadedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['theme'] = Variable<String>(theme);
    map['rating_min'] = Variable<int>(ratingMin);
    map['rating_max'] = Variable<int>(ratingMax);
    map['count'] = Variable<int>(count);
    map['bytes'] = Variable<int>(bytes);
    map['version'] = Variable<int>(version);
    map['downloaded_at'] = Variable<DateTime>(downloadedAt);
    return map;
  }

  PuzzlePacksCompanion toCompanion(bool nullToAbsent) {
    return PuzzlePacksCompanion(
      id: Value(id),
      theme: Value(theme),
      ratingMin: Value(ratingMin),
      ratingMax: Value(ratingMax),
      count: Value(count),
      bytes: Value(bytes),
      version: Value(version),
      downloadedAt: Value(downloadedAt),
    );
  }

  factory PuzzlePack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PuzzlePack(
      id: serializer.fromJson<String>(json['id']),
      theme: serializer.fromJson<String>(json['theme']),
      ratingMin: serializer.fromJson<int>(json['ratingMin']),
      ratingMax: serializer.fromJson<int>(json['ratingMax']),
      count: serializer.fromJson<int>(json['count']),
      bytes: serializer.fromJson<int>(json['bytes']),
      version: serializer.fromJson<int>(json['version']),
      downloadedAt: serializer.fromJson<DateTime>(json['downloadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'theme': serializer.toJson<String>(theme),
      'ratingMin': serializer.toJson<int>(ratingMin),
      'ratingMax': serializer.toJson<int>(ratingMax),
      'count': serializer.toJson<int>(count),
      'bytes': serializer.toJson<int>(bytes),
      'version': serializer.toJson<int>(version),
      'downloadedAt': serializer.toJson<DateTime>(downloadedAt),
    };
  }

  PuzzlePack copyWith({
    String? id,
    String? theme,
    int? ratingMin,
    int? ratingMax,
    int? count,
    int? bytes,
    int? version,
    DateTime? downloadedAt,
  }) => PuzzlePack(
    id: id ?? this.id,
    theme: theme ?? this.theme,
    ratingMin: ratingMin ?? this.ratingMin,
    ratingMax: ratingMax ?? this.ratingMax,
    count: count ?? this.count,
    bytes: bytes ?? this.bytes,
    version: version ?? this.version,
    downloadedAt: downloadedAt ?? this.downloadedAt,
  );
  PuzzlePack copyWithCompanion(PuzzlePacksCompanion data) {
    return PuzzlePack(
      id: data.id.present ? data.id.value : this.id,
      theme: data.theme.present ? data.theme.value : this.theme,
      ratingMin: data.ratingMin.present ? data.ratingMin.value : this.ratingMin,
      ratingMax: data.ratingMax.present ? data.ratingMax.value : this.ratingMax,
      count: data.count.present ? data.count.value : this.count,
      bytes: data.bytes.present ? data.bytes.value : this.bytes,
      version: data.version.present ? data.version.value : this.version,
      downloadedAt: data.downloadedAt.present
          ? data.downloadedAt.value
          : this.downloadedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PuzzlePack(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('ratingMin: $ratingMin, ')
          ..write('ratingMax: $ratingMax, ')
          ..write('count: $count, ')
          ..write('bytes: $bytes, ')
          ..write('version: $version, ')
          ..write('downloadedAt: $downloadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    theme,
    ratingMin,
    ratingMax,
    count,
    bytes,
    version,
    downloadedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PuzzlePack &&
          other.id == this.id &&
          other.theme == this.theme &&
          other.ratingMin == this.ratingMin &&
          other.ratingMax == this.ratingMax &&
          other.count == this.count &&
          other.bytes == this.bytes &&
          other.version == this.version &&
          other.downloadedAt == this.downloadedAt);
}

class PuzzlePacksCompanion extends UpdateCompanion<PuzzlePack> {
  final Value<String> id;
  final Value<String> theme;
  final Value<int> ratingMin;
  final Value<int> ratingMax;
  final Value<int> count;
  final Value<int> bytes;
  final Value<int> version;
  final Value<DateTime> downloadedAt;
  final Value<int> rowid;
  const PuzzlePacksCompanion({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    this.ratingMin = const Value.absent(),
    this.ratingMax = const Value.absent(),
    this.count = const Value.absent(),
    this.bytes = const Value.absent(),
    this.version = const Value.absent(),
    this.downloadedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PuzzlePacksCompanion.insert({
    required String id,
    required String theme,
    required int ratingMin,
    required int ratingMax,
    required int count,
    required int bytes,
    required int version,
    required DateTime downloadedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       theme = Value(theme),
       ratingMin = Value(ratingMin),
       ratingMax = Value(ratingMax),
       count = Value(count),
       bytes = Value(bytes),
       version = Value(version),
       downloadedAt = Value(downloadedAt);
  static Insertable<PuzzlePack> custom({
    Expression<String>? id,
    Expression<String>? theme,
    Expression<int>? ratingMin,
    Expression<int>? ratingMax,
    Expression<int>? count,
    Expression<int>? bytes,
    Expression<int>? version,
    Expression<DateTime>? downloadedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (theme != null) 'theme': theme,
      if (ratingMin != null) 'rating_min': ratingMin,
      if (ratingMax != null) 'rating_max': ratingMax,
      if (count != null) 'count': count,
      if (bytes != null) 'bytes': bytes,
      if (version != null) 'version': version,
      if (downloadedAt != null) 'downloaded_at': downloadedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PuzzlePacksCompanion copyWith({
    Value<String>? id,
    Value<String>? theme,
    Value<int>? ratingMin,
    Value<int>? ratingMax,
    Value<int>? count,
    Value<int>? bytes,
    Value<int>? version,
    Value<DateTime>? downloadedAt,
    Value<int>? rowid,
  }) {
    return PuzzlePacksCompanion(
      id: id ?? this.id,
      theme: theme ?? this.theme,
      ratingMin: ratingMin ?? this.ratingMin,
      ratingMax: ratingMax ?? this.ratingMax,
      count: count ?? this.count,
      bytes: bytes ?? this.bytes,
      version: version ?? this.version,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (ratingMin.present) {
      map['rating_min'] = Variable<int>(ratingMin.value);
    }
    if (ratingMax.present) {
      map['rating_max'] = Variable<int>(ratingMax.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (bytes.present) {
      map['bytes'] = Variable<int>(bytes.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (downloadedAt.present) {
      map['downloaded_at'] = Variable<DateTime>(downloadedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PuzzlePacksCompanion(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('ratingMin: $ratingMin, ')
          ..write('ratingMax: $ratingMax, ')
          ..write('count: $count, ')
          ..write('bytes: $bytes, ')
          ..write('version: $version, ')
          ..write('downloadedAt: $downloadedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PuzzleAttemptsTable extends PuzzleAttempts
    with TableInfo<$PuzzleAttemptsTable, PuzzleAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PuzzleAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puzzleIdMeta = const VerificationMeta(
    'puzzleId',
  );
  @override
  late final GeneratedColumn<String> puzzleId = GeneratedColumn<String>(
    'puzzle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _solvedMeta = const VerificationMeta('solved');
  @override
  late final GeneratedColumn<bool> solved = GeneratedColumn<bool>(
    'solved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("solved" IN (0, 1))',
    ),
  );
  static const VerificationMeta _hintsUsedMeta = const VerificationMeta(
    'hintsUsed',
  );
  @override
  late final GeneratedColumn<int> hintsUsed = GeneratedColumn<int>(
    'hints_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timeMsMeta = const VerificationMeta('timeMs');
  @override
  late final GeneratedColumn<int> timeMs = GeneratedColumn<int>(
    'time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puzzleRatingMeta = const VerificationMeta(
    'puzzleRating',
  );
  @override
  late final GeneratedColumn<int> puzzleRating = GeneratedColumn<int>(
    'puzzle_rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingAfterMeta = const VerificationMeta(
    'ratingAfter',
  );
  @override
  late final GeneratedColumn<double> ratingAfter = GeneratedColumn<double>(
    'rating_after',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rdAfterMeta = const VerificationMeta(
    'rdAfter',
  );
  @override
  late final GeneratedColumn<double> rdAfter = GeneratedColumn<double>(
    'rd_after',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volAfterMeta = const VerificationMeta(
    'volAfter',
  );
  @override
  late final GeneratedColumn<double> volAfter = GeneratedColumn<double>(
    'vol_after',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptedAtMeta = const VerificationMeta(
    'attemptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> attemptedAt = GeneratedColumn<DateTime>(
    'attempted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    puzzleId,
    solved,
    hintsUsed,
    timeMs,
    puzzleRating,
    ratingAfter,
    rdAfter,
    volAfter,
    attemptedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'puzzle_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PuzzleAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
    }
    if (data.containsKey('solved')) {
      context.handle(
        _solvedMeta,
        solved.isAcceptableOrUnknown(data['solved']!, _solvedMeta),
      );
    } else if (isInserting) {
      context.missing(_solvedMeta);
    }
    if (data.containsKey('hints_used')) {
      context.handle(
        _hintsUsedMeta,
        hintsUsed.isAcceptableOrUnknown(data['hints_used']!, _hintsUsedMeta),
      );
    }
    if (data.containsKey('time_ms')) {
      context.handle(
        _timeMsMeta,
        timeMs.isAcceptableOrUnknown(data['time_ms']!, _timeMsMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMsMeta);
    }
    if (data.containsKey('puzzle_rating')) {
      context.handle(
        _puzzleRatingMeta,
        puzzleRating.isAcceptableOrUnknown(
          data['puzzle_rating']!,
          _puzzleRatingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_puzzleRatingMeta);
    }
    if (data.containsKey('rating_after')) {
      context.handle(
        _ratingAfterMeta,
        ratingAfter.isAcceptableOrUnknown(
          data['rating_after']!,
          _ratingAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ratingAfterMeta);
    }
    if (data.containsKey('rd_after')) {
      context.handle(
        _rdAfterMeta,
        rdAfter.isAcceptableOrUnknown(data['rd_after']!, _rdAfterMeta),
      );
    } else if (isInserting) {
      context.missing(_rdAfterMeta);
    }
    if (data.containsKey('vol_after')) {
      context.handle(
        _volAfterMeta,
        volAfter.isAcceptableOrUnknown(data['vol_after']!, _volAfterMeta),
      );
    } else if (isInserting) {
      context.missing(_volAfterMeta);
    }
    if (data.containsKey('attempted_at')) {
      context.handle(
        _attemptedAtMeta,
        attemptedAt.isAcceptableOrUnknown(
          data['attempted_at']!,
          _attemptedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PuzzleAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PuzzleAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      solved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}solved'],
      )!,
      hintsUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hints_used'],
      )!,
      timeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_ms'],
      )!,
      puzzleRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}puzzle_rating'],
      )!,
      ratingAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating_after'],
      )!,
      rdAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rd_after'],
      )!,
      volAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vol_after'],
      )!,
      attemptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}attempted_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $PuzzleAttemptsTable createAlias(String alias) {
    return $PuzzleAttemptsTable(attachedDatabase, alias);
  }
}

class PuzzleAttempt extends DataClass implements Insertable<PuzzleAttempt> {
  final String id;
  final String puzzleId;
  final bool solved;
  final int hintsUsed;
  final int timeMs;
  final int puzzleRating;
  final double ratingAfter;
  final double rdAfter;
  final double volAfter;
  final DateTime attemptedAt;
  final DateTime? syncedAt;
  const PuzzleAttempt({
    required this.id,
    required this.puzzleId,
    required this.solved,
    required this.hintsUsed,
    required this.timeMs,
    required this.puzzleRating,
    required this.ratingAfter,
    required this.rdAfter,
    required this.volAfter,
    required this.attemptedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['puzzle_id'] = Variable<String>(puzzleId);
    map['solved'] = Variable<bool>(solved);
    map['hints_used'] = Variable<int>(hintsUsed);
    map['time_ms'] = Variable<int>(timeMs);
    map['puzzle_rating'] = Variable<int>(puzzleRating);
    map['rating_after'] = Variable<double>(ratingAfter);
    map['rd_after'] = Variable<double>(rdAfter);
    map['vol_after'] = Variable<double>(volAfter);
    map['attempted_at'] = Variable<DateTime>(attemptedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  PuzzleAttemptsCompanion toCompanion(bool nullToAbsent) {
    return PuzzleAttemptsCompanion(
      id: Value(id),
      puzzleId: Value(puzzleId),
      solved: Value(solved),
      hintsUsed: Value(hintsUsed),
      timeMs: Value(timeMs),
      puzzleRating: Value(puzzleRating),
      ratingAfter: Value(ratingAfter),
      rdAfter: Value(rdAfter),
      volAfter: Value(volAfter),
      attemptedAt: Value(attemptedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory PuzzleAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PuzzleAttempt(
      id: serializer.fromJson<String>(json['id']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      solved: serializer.fromJson<bool>(json['solved']),
      hintsUsed: serializer.fromJson<int>(json['hintsUsed']),
      timeMs: serializer.fromJson<int>(json['timeMs']),
      puzzleRating: serializer.fromJson<int>(json['puzzleRating']),
      ratingAfter: serializer.fromJson<double>(json['ratingAfter']),
      rdAfter: serializer.fromJson<double>(json['rdAfter']),
      volAfter: serializer.fromJson<double>(json['volAfter']),
      attemptedAt: serializer.fromJson<DateTime>(json['attemptedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'solved': serializer.toJson<bool>(solved),
      'hintsUsed': serializer.toJson<int>(hintsUsed),
      'timeMs': serializer.toJson<int>(timeMs),
      'puzzleRating': serializer.toJson<int>(puzzleRating),
      'ratingAfter': serializer.toJson<double>(ratingAfter),
      'rdAfter': serializer.toJson<double>(rdAfter),
      'volAfter': serializer.toJson<double>(volAfter),
      'attemptedAt': serializer.toJson<DateTime>(attemptedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  PuzzleAttempt copyWith({
    String? id,
    String? puzzleId,
    bool? solved,
    int? hintsUsed,
    int? timeMs,
    int? puzzleRating,
    double? ratingAfter,
    double? rdAfter,
    double? volAfter,
    DateTime? attemptedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => PuzzleAttempt(
    id: id ?? this.id,
    puzzleId: puzzleId ?? this.puzzleId,
    solved: solved ?? this.solved,
    hintsUsed: hintsUsed ?? this.hintsUsed,
    timeMs: timeMs ?? this.timeMs,
    puzzleRating: puzzleRating ?? this.puzzleRating,
    ratingAfter: ratingAfter ?? this.ratingAfter,
    rdAfter: rdAfter ?? this.rdAfter,
    volAfter: volAfter ?? this.volAfter,
    attemptedAt: attemptedAt ?? this.attemptedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  PuzzleAttempt copyWithCompanion(PuzzleAttemptsCompanion data) {
    return PuzzleAttempt(
      id: data.id.present ? data.id.value : this.id,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      solved: data.solved.present ? data.solved.value : this.solved,
      hintsUsed: data.hintsUsed.present ? data.hintsUsed.value : this.hintsUsed,
      timeMs: data.timeMs.present ? data.timeMs.value : this.timeMs,
      puzzleRating: data.puzzleRating.present
          ? data.puzzleRating.value
          : this.puzzleRating,
      ratingAfter: data.ratingAfter.present
          ? data.ratingAfter.value
          : this.ratingAfter,
      rdAfter: data.rdAfter.present ? data.rdAfter.value : this.rdAfter,
      volAfter: data.volAfter.present ? data.volAfter.value : this.volAfter,
      attemptedAt: data.attemptedAt.present
          ? data.attemptedAt.value
          : this.attemptedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PuzzleAttempt(')
          ..write('id: $id, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('solved: $solved, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('timeMs: $timeMs, ')
          ..write('puzzleRating: $puzzleRating, ')
          ..write('ratingAfter: $ratingAfter, ')
          ..write('rdAfter: $rdAfter, ')
          ..write('volAfter: $volAfter, ')
          ..write('attemptedAt: $attemptedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    puzzleId,
    solved,
    hintsUsed,
    timeMs,
    puzzleRating,
    ratingAfter,
    rdAfter,
    volAfter,
    attemptedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PuzzleAttempt &&
          other.id == this.id &&
          other.puzzleId == this.puzzleId &&
          other.solved == this.solved &&
          other.hintsUsed == this.hintsUsed &&
          other.timeMs == this.timeMs &&
          other.puzzleRating == this.puzzleRating &&
          other.ratingAfter == this.ratingAfter &&
          other.rdAfter == this.rdAfter &&
          other.volAfter == this.volAfter &&
          other.attemptedAt == this.attemptedAt &&
          other.syncedAt == this.syncedAt);
}

class PuzzleAttemptsCompanion extends UpdateCompanion<PuzzleAttempt> {
  final Value<String> id;
  final Value<String> puzzleId;
  final Value<bool> solved;
  final Value<int> hintsUsed;
  final Value<int> timeMs;
  final Value<int> puzzleRating;
  final Value<double> ratingAfter;
  final Value<double> rdAfter;
  final Value<double> volAfter;
  final Value<DateTime> attemptedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const PuzzleAttemptsCompanion({
    this.id = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.solved = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.timeMs = const Value.absent(),
    this.puzzleRating = const Value.absent(),
    this.ratingAfter = const Value.absent(),
    this.rdAfter = const Value.absent(),
    this.volAfter = const Value.absent(),
    this.attemptedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PuzzleAttemptsCompanion.insert({
    required String id,
    required String puzzleId,
    required bool solved,
    this.hintsUsed = const Value.absent(),
    required int timeMs,
    required int puzzleRating,
    required double ratingAfter,
    required double rdAfter,
    required double volAfter,
    required DateTime attemptedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       puzzleId = Value(puzzleId),
       solved = Value(solved),
       timeMs = Value(timeMs),
       puzzleRating = Value(puzzleRating),
       ratingAfter = Value(ratingAfter),
       rdAfter = Value(rdAfter),
       volAfter = Value(volAfter),
       attemptedAt = Value(attemptedAt);
  static Insertable<PuzzleAttempt> custom({
    Expression<String>? id,
    Expression<String>? puzzleId,
    Expression<bool>? solved,
    Expression<int>? hintsUsed,
    Expression<int>? timeMs,
    Expression<int>? puzzleRating,
    Expression<double>? ratingAfter,
    Expression<double>? rdAfter,
    Expression<double>? volAfter,
    Expression<DateTime>? attemptedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (solved != null) 'solved': solved,
      if (hintsUsed != null) 'hints_used': hintsUsed,
      if (timeMs != null) 'time_ms': timeMs,
      if (puzzleRating != null) 'puzzle_rating': puzzleRating,
      if (ratingAfter != null) 'rating_after': ratingAfter,
      if (rdAfter != null) 'rd_after': rdAfter,
      if (volAfter != null) 'vol_after': volAfter,
      if (attemptedAt != null) 'attempted_at': attemptedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PuzzleAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? puzzleId,
    Value<bool>? solved,
    Value<int>? hintsUsed,
    Value<int>? timeMs,
    Value<int>? puzzleRating,
    Value<double>? ratingAfter,
    Value<double>? rdAfter,
    Value<double>? volAfter,
    Value<DateTime>? attemptedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return PuzzleAttemptsCompanion(
      id: id ?? this.id,
      puzzleId: puzzleId ?? this.puzzleId,
      solved: solved ?? this.solved,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      timeMs: timeMs ?? this.timeMs,
      puzzleRating: puzzleRating ?? this.puzzleRating,
      ratingAfter: ratingAfter ?? this.ratingAfter,
      rdAfter: rdAfter ?? this.rdAfter,
      volAfter: volAfter ?? this.volAfter,
      attemptedAt: attemptedAt ?? this.attemptedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (solved.present) {
      map['solved'] = Variable<bool>(solved.value);
    }
    if (hintsUsed.present) {
      map['hints_used'] = Variable<int>(hintsUsed.value);
    }
    if (timeMs.present) {
      map['time_ms'] = Variable<int>(timeMs.value);
    }
    if (puzzleRating.present) {
      map['puzzle_rating'] = Variable<int>(puzzleRating.value);
    }
    if (ratingAfter.present) {
      map['rating_after'] = Variable<double>(ratingAfter.value);
    }
    if (rdAfter.present) {
      map['rd_after'] = Variable<double>(rdAfter.value);
    }
    if (volAfter.present) {
      map['vol_after'] = Variable<double>(volAfter.value);
    }
    if (attemptedAt.present) {
      map['attempted_at'] = Variable<DateTime>(attemptedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PuzzleAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('solved: $solved, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('timeMs: $timeMs, ')
          ..write('puzzleRating: $puzzleRating, ')
          ..write('ratingAfter: $ratingAfter, ')
          ..write('rdAfter: $rdAfter, ')
          ..write('volAfter: $volAfter, ')
          ..write('attemptedAt: $attemptedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VisionSessionsTable extends VisionSessions
    with TableInfo<$VisionSessionsTable, VisionSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisionSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
    'side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coordsMeta = const VerificationMeta('coords');
  @override
  late final GeneratedColumn<bool> coords = GeneratedColumn<bool>(
    'coords',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("coords" IN (0, 1))',
    ),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorsMeta = const VerificationMeta('errors');
  @override
  late final GeneratedColumn<int> errors = GeneratedColumn<int>(
    'errors',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _missesMeta = const VerificationMeta('misses');
  @override
  late final GeneratedColumn<String> misses = GeneratedColumn<String>(
    'misses',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mode,
    side,
    coords,
    score,
    errors,
    durationMs,
    misses,
    startedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vision_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<VisionSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('side')) {
      context.handle(
        _sideMeta,
        side.isAcceptableOrUnknown(data['side']!, _sideMeta),
      );
    } else if (isInserting) {
      context.missing(_sideMeta);
    }
    if (data.containsKey('coords')) {
      context.handle(
        _coordsMeta,
        coords.isAcceptableOrUnknown(data['coords']!, _coordsMeta),
      );
    } else if (isInserting) {
      context.missing(_coordsMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('errors')) {
      context.handle(
        _errorsMeta,
        errors.isAcceptableOrUnknown(data['errors']!, _errorsMeta),
      );
    } else if (isInserting) {
      context.missing(_errorsMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('misses')) {
      context.handle(
        _missesMeta,
        misses.isAcceptableOrUnknown(data['misses']!, _missesMeta),
      );
    } else if (isInserting) {
      context.missing(_missesMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisionSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisionSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      side: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}side'],
      )!,
      coords: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}coords'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      errors: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}errors'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      misses: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}misses'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $VisionSessionsTable createAlias(String alias) {
    return $VisionSessionsTable(attachedDatabase, alias);
  }
}

class VisionSession extends DataClass implements Insertable<VisionSession> {
  final String id;
  final String mode;
  final String side;
  final bool coords;
  final int score;
  final int errors;
  final int durationMs;
  final String misses;
  final DateTime startedAt;
  final DateTime? syncedAt;
  const VisionSession({
    required this.id,
    required this.mode,
    required this.side,
    required this.coords,
    required this.score,
    required this.errors,
    required this.durationMs,
    required this.misses,
    required this.startedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mode'] = Variable<String>(mode);
    map['side'] = Variable<String>(side);
    map['coords'] = Variable<bool>(coords);
    map['score'] = Variable<int>(score);
    map['errors'] = Variable<int>(errors);
    map['duration_ms'] = Variable<int>(durationMs);
    map['misses'] = Variable<String>(misses);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  VisionSessionsCompanion toCompanion(bool nullToAbsent) {
    return VisionSessionsCompanion(
      id: Value(id),
      mode: Value(mode),
      side: Value(side),
      coords: Value(coords),
      score: Value(score),
      errors: Value(errors),
      durationMs: Value(durationMs),
      misses: Value(misses),
      startedAt: Value(startedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory VisionSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisionSession(
      id: serializer.fromJson<String>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      side: serializer.fromJson<String>(json['side']),
      coords: serializer.fromJson<bool>(json['coords']),
      score: serializer.fromJson<int>(json['score']),
      errors: serializer.fromJson<int>(json['errors']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      misses: serializer.fromJson<String>(json['misses']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mode': serializer.toJson<String>(mode),
      'side': serializer.toJson<String>(side),
      'coords': serializer.toJson<bool>(coords),
      'score': serializer.toJson<int>(score),
      'errors': serializer.toJson<int>(errors),
      'durationMs': serializer.toJson<int>(durationMs),
      'misses': serializer.toJson<String>(misses),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  VisionSession copyWith({
    String? id,
    String? mode,
    String? side,
    bool? coords,
    int? score,
    int? errors,
    int? durationMs,
    String? misses,
    DateTime? startedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => VisionSession(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    side: side ?? this.side,
    coords: coords ?? this.coords,
    score: score ?? this.score,
    errors: errors ?? this.errors,
    durationMs: durationMs ?? this.durationMs,
    misses: misses ?? this.misses,
    startedAt: startedAt ?? this.startedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  VisionSession copyWithCompanion(VisionSessionsCompanion data) {
    return VisionSession(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      side: data.side.present ? data.side.value : this.side,
      coords: data.coords.present ? data.coords.value : this.coords,
      score: data.score.present ? data.score.value : this.score,
      errors: data.errors.present ? data.errors.value : this.errors,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      misses: data.misses.present ? data.misses.value : this.misses,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisionSession(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('side: $side, ')
          ..write('coords: $coords, ')
          ..write('score: $score, ')
          ..write('errors: $errors, ')
          ..write('durationMs: $durationMs, ')
          ..write('misses: $misses, ')
          ..write('startedAt: $startedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mode,
    side,
    coords,
    score,
    errors,
    durationMs,
    misses,
    startedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisionSession &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.side == this.side &&
          other.coords == this.coords &&
          other.score == this.score &&
          other.errors == this.errors &&
          other.durationMs == this.durationMs &&
          other.misses == this.misses &&
          other.startedAt == this.startedAt &&
          other.syncedAt == this.syncedAt);
}

class VisionSessionsCompanion extends UpdateCompanion<VisionSession> {
  final Value<String> id;
  final Value<String> mode;
  final Value<String> side;
  final Value<bool> coords;
  final Value<int> score;
  final Value<int> errors;
  final Value<int> durationMs;
  final Value<String> misses;
  final Value<DateTime> startedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const VisionSessionsCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.side = const Value.absent(),
    this.coords = const Value.absent(),
    this.score = const Value.absent(),
    this.errors = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.misses = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VisionSessionsCompanion.insert({
    required String id,
    required String mode,
    required String side,
    required bool coords,
    required int score,
    required int errors,
    required int durationMs,
    required String misses,
    required DateTime startedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mode = Value(mode),
       side = Value(side),
       coords = Value(coords),
       score = Value(score),
       errors = Value(errors),
       durationMs = Value(durationMs),
       misses = Value(misses),
       startedAt = Value(startedAt);
  static Insertable<VisionSession> custom({
    Expression<String>? id,
    Expression<String>? mode,
    Expression<String>? side,
    Expression<bool>? coords,
    Expression<int>? score,
    Expression<int>? errors,
    Expression<int>? durationMs,
    Expression<String>? misses,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (side != null) 'side': side,
      if (coords != null) 'coords': coords,
      if (score != null) 'score': score,
      if (errors != null) 'errors': errors,
      if (durationMs != null) 'duration_ms': durationMs,
      if (misses != null) 'misses': misses,
      if (startedAt != null) 'started_at': startedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VisionSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? mode,
    Value<String>? side,
    Value<bool>? coords,
    Value<int>? score,
    Value<int>? errors,
    Value<int>? durationMs,
    Value<String>? misses,
    Value<DateTime>? startedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return VisionSessionsCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      side: side ?? this.side,
      coords: coords ?? this.coords,
      score: score ?? this.score,
      errors: errors ?? this.errors,
      durationMs: durationMs ?? this.durationMs,
      misses: misses ?? this.misses,
      startedAt: startedAt ?? this.startedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (coords.present) {
      map['coords'] = Variable<bool>(coords.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (errors.present) {
      map['errors'] = Variable<int>(errors.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (misses.present) {
      map['misses'] = Variable<String>(misses.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisionSessionsCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('side: $side, ')
          ..write('coords: $coords, ')
          ..write('score: $score, ')
          ..write('errors: $errors, ')
          ..write('durationMs: $durationMs, ')
          ..write('misses: $misses, ')
          ..write('startedAt: $startedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GamesTable games = $GamesTable(this);
  late final $PositionEvalsTable positionEvals = $PositionEvalsTable(this);
  late final $GameAnalysesTable gameAnalyses = $GameAnalysesTable(this);
  late final $PuzzlesTable puzzles = $PuzzlesTable(this);
  late final $PuzzlePacksTable puzzlePacks = $PuzzlePacksTable(this);
  late final $PuzzleAttemptsTable puzzleAttempts = $PuzzleAttemptsTable(this);
  late final $VisionSessionsTable visionSessions = $VisionSessionsTable(this);
  late final Index gamesCreated = Index(
    'games_created',
    'CREATE INDEX games_created ON games (created_at)',
  );
  late final Index puzzlesRating = Index(
    'puzzles_rating',
    'CREATE INDEX puzzles_rating ON puzzles (rating)',
  );
  late final Index attemptsTime = Index(
    'attempts_time',
    'CREATE INDEX attempts_time ON puzzle_attempts (attempted_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    games,
    positionEvals,
    gameAnalyses,
    puzzles,
    puzzlePacks,
    puzzleAttempts,
    visionSessions,
    gamesCreated,
    puzzlesRating,
    attemptsTime,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'games',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('game_analyses', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GamesTableCreateCompanionBuilder = GamesCompanion Function({
  Value<int> id,
  required String source,
  Value<String?> externalId,
  required String pgn,
  required String white,
  required String black,
  required String result,
  Value<String?> date,
  Value<String?> timeControl,
  Value<String?> userSide,
  Value<String?> eco,
  Value<String?> openingName,
  required int plies,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> deleted,
});
typedef $$GamesTableUpdateCompanionBuilder = GamesCompanion Function({
  Value<int> id,
  Value<String> source,
  Value<String?> externalId,
  Value<String> pgn,
  Value<String> white,
  Value<String> black,
  Value<String> result,
  Value<String?> date,
  Value<String?> timeControl,
  Value<String?> userSide,
  Value<String?> eco,
  Value<String?> openingName,
  Value<int> plies,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> deleted,
});

final class $$GamesTableReferences
    extends BaseReferences<_$AppDatabase, $GamesTable, Game> {
  $$GamesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GameAnalysesTable, List<GameAnalyse>>
  _gameAnalysesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gameAnalyses,
    aliasName: 'games__id__game_analyses__game_id',
  );

  $$GameAnalysesTableProcessedTableManager get gameAnalysesRefs {
    final manager = $$GameAnalysesTableTableManager(
      $_db,
      $_db.gameAnalyses,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gameAnalysesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GamesTableFilterComposer extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pgn => $composableBuilder(
    column: $table.pgn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get white => $composableBuilder(
    column: $table.white,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get black => $composableBuilder(
    column: $table.black,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeControl => $composableBuilder(
    column: $table.timeControl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userSide => $composableBuilder(
    column: $table.userSide,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eco => $composableBuilder(
    column: $table.eco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openingName => $composableBuilder(
    column: $table.openingName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plies => $composableBuilder(
    column: $table.plies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gameAnalysesRefs(
    Expression<bool> Function($$GameAnalysesTableFilterComposer f) f,
  ) {
    final $$GameAnalysesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameAnalyses,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameAnalysesTableFilterComposer(
            $db: $db,
            $table: $db.gameAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GamesTableOrderingComposer
    extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pgn => $composableBuilder(
    column: $table.pgn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get white => $composableBuilder(
    column: $table.white,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get black => $composableBuilder(
    column: $table.black,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeControl => $composableBuilder(
    column: $table.timeControl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userSide => $composableBuilder(
    column: $table.userSide,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eco => $composableBuilder(
    column: $table.eco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingName => $composableBuilder(
    column: $table.openingName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plies => $composableBuilder(
    column: $table.plies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GamesTable> {
  $$GamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pgn =>
      $composableBuilder(column: $table.pgn, builder: (column) => column);

  GeneratedColumn<String> get white =>
      $composableBuilder(column: $table.white, builder: (column) => column);

  GeneratedColumn<String> get black =>
      $composableBuilder(column: $table.black, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get timeControl => $composableBuilder(
    column: $table.timeControl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userSide =>
      $composableBuilder(column: $table.userSide, builder: (column) => column);

  GeneratedColumn<String> get eco =>
      $composableBuilder(column: $table.eco, builder: (column) => column);

  GeneratedColumn<String> get openingName => $composableBuilder(
    column: $table.openingName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plies =>
      $composableBuilder(column: $table.plies, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  Expression<T> gameAnalysesRefs<T extends Object>(
    Expression<T> Function($$GameAnalysesTableAnnotationComposer a) f,
  ) {
    final $$GameAnalysesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameAnalyses,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameAnalysesTableAnnotationComposer(
            $db: $db,
            $table: $db.gameAnalyses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GamesTable,
          Game,
          $$GamesTableFilterComposer,
          $$GamesTableOrderingComposer,
          $$GamesTableAnnotationComposer,
          $$GamesTableCreateCompanionBuilder,
          $$GamesTableUpdateCompanionBuilder,
          (Game, $$GamesTableReferences),
          Game,
          PrefetchHooks Function({bool gameAnalysesRefs})
        > {
  $$GamesTableTableManager(_$AppDatabase db, $GamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<String> pgn = const Value.absent(),
                Value<String> white = const Value.absent(),
                Value<String> black = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<String?> date = const Value.absent(),
                Value<String?> timeControl = const Value.absent(),
                Value<String?> userSide = const Value.absent(),
                Value<String?> eco = const Value.absent(),
                Value<String?> openingName = const Value.absent(),
                Value<int> plies = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
              }) => GamesCompanion(
                id: id,
                source: source,
                externalId: externalId,
                pgn: pgn,
                white: white,
                black: black,
                result: result,
                date: date,
                timeControl: timeControl,
                userSide: userSide,
                eco: eco,
                openingName: openingName,
                plies: plies,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deleted: deleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String source,
                Value<String?> externalId = const Value.absent(),
                required String pgn,
                required String white,
                required String black,
                required String result,
                Value<String?> date = const Value.absent(),
                Value<String?> timeControl = const Value.absent(),
                Value<String?> userSide = const Value.absent(),
                Value<String?> eco = const Value.absent(),
                Value<String?> openingName = const Value.absent(),
                required int plies,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> deleted = const Value.absent(),
              }) => GamesCompanion.insert(
                id: id,
                source: source,
                externalId: externalId,
                pgn: pgn,
                white: white,
                black: black,
                result: result,
                date: date,
                timeControl: timeControl,
                userSide: userSide,
                eco: eco,
                openingName: openingName,
                plies: plies,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deleted: deleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GamesTable, Game>(table),
                  $$GamesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gameAnalysesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (gameAnalysesRefs) db.gameAnalyses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gameAnalysesRefs)
                    await $_getPrefetchedDataByColumns<
                      Game,
                      $GamesTable,
                      GameAnalyse,
                      $GameAnalysesTable
                    >(
                      currentTable: table,
                      referencedTable: $$GamesTableReferences
                          ._gameAnalysesRefsTable(db),
                      managerFromTypedResult: (p0) => $$GamesTableReferences(
                        db,
                        table,
                        p0,
                      ).gameAnalysesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'game_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GamesTable,
      Game,
      $$GamesTableFilterComposer,
      $$GamesTableOrderingComposer,
      $$GamesTableAnnotationComposer,
      $$GamesTableCreateCompanionBuilder,
      $$GamesTableUpdateCompanionBuilder,
      (Game, $$GamesTableReferences),
      Game,
      PrefetchHooks Function({bool gameAnalysesRefs})
    >;
typedef $$PositionEvalsTableCreateCompanionBuilder =
    PositionEvalsCompanion Function({
      required String epd,
      required String engine,
      required String preset,
      required String lines,
      Value<int> rowid,
    });
typedef $$PositionEvalsTableUpdateCompanionBuilder =
    PositionEvalsCompanion Function({
      Value<String> epd,
      Value<String> engine,
      Value<String> preset,
      Value<String> lines,
      Value<int> rowid,
    });

class $$PositionEvalsTableFilterComposer
    extends Composer<_$AppDatabase, $PositionEvalsTable> {
  $$PositionEvalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get epd => $composableBuilder(
    column: $table.epd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preset => $composableBuilder(
    column: $table.preset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lines => $composableBuilder(
    column: $table.lines,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PositionEvalsTableOrderingComposer
    extends Composer<_$AppDatabase, $PositionEvalsTable> {
  $$PositionEvalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get epd => $composableBuilder(
    column: $table.epd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preset => $composableBuilder(
    column: $table.preset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lines => $composableBuilder(
    column: $table.lines,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PositionEvalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PositionEvalsTable> {
  $$PositionEvalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get epd =>
      $composableBuilder(column: $table.epd, builder: (column) => column);

  GeneratedColumn<String> get engine =>
      $composableBuilder(column: $table.engine, builder: (column) => column);

  GeneratedColumn<String> get preset =>
      $composableBuilder(column: $table.preset, builder: (column) => column);

  GeneratedColumn<String> get lines =>
      $composableBuilder(column: $table.lines, builder: (column) => column);
}

class $$PositionEvalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PositionEvalsTable,
          PositionEval,
          $$PositionEvalsTableFilterComposer,
          $$PositionEvalsTableOrderingComposer,
          $$PositionEvalsTableAnnotationComposer,
          $$PositionEvalsTableCreateCompanionBuilder,
          $$PositionEvalsTableUpdateCompanionBuilder,
          (
            PositionEval,
            BaseReferences<_$AppDatabase, $PositionEvalsTable, PositionEval>,
          ),
          PositionEval,
          PrefetchHooks Function()
        > {
  $$PositionEvalsTableTableManager(_$AppDatabase db, $PositionEvalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PositionEvalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PositionEvalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PositionEvalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> epd = const Value.absent(),
                Value<String> engine = const Value.absent(),
                Value<String> preset = const Value.absent(),
                Value<String> lines = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PositionEvalsCompanion(
                epd: epd,
                engine: engine,
                preset: preset,
                lines: lines,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String epd,
                required String engine,
                required String preset,
                required String lines,
                Value<int> rowid = const Value.absent(),
              }) => PositionEvalsCompanion.insert(
                epd: epd,
                engine: engine,
                preset: preset,
                lines: lines,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PositionEvalsTable, PositionEval>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PositionEvalsTable,
                    PositionEval
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PositionEvalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PositionEvalsTable,
      PositionEval,
      $$PositionEvalsTableFilterComposer,
      $$PositionEvalsTableOrderingComposer,
      $$PositionEvalsTableAnnotationComposer,
      $$PositionEvalsTableCreateCompanionBuilder,
      $$PositionEvalsTableUpdateCompanionBuilder,
      (
        PositionEval,
        BaseReferences<_$AppDatabase, $PositionEvalsTable, PositionEval>,
      ),
      PositionEval,
      PrefetchHooks Function()
    >;
typedef $$GameAnalysesTableCreateCompanionBuilder =
    GameAnalysesCompanion Function({
      Value<int> gameId,
      required String engine,
      required String preset,
      Value<double?> accuracyWhite,
      Value<double?> accuracyBlack,
      Value<double?> userAccuracy,
      Value<int> userInaccuracies,
      Value<int> userMistakes,
      Value<int> userBlunders,
      required String report,
      required DateTime createdAt,
    });
typedef $$GameAnalysesTableUpdateCompanionBuilder =
    GameAnalysesCompanion Function({
      Value<int> gameId,
      Value<String> engine,
      Value<String> preset,
      Value<double?> accuracyWhite,
      Value<double?> accuracyBlack,
      Value<double?> userAccuracy,
      Value<int> userInaccuracies,
      Value<int> userMistakes,
      Value<int> userBlunders,
      Value<String> report,
      Value<DateTime> createdAt,
    });

final class $$GameAnalysesTableReferences
    extends BaseReferences<_$AppDatabase, $GameAnalysesTable, GameAnalyse> {
  $$GameAnalysesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GamesTable _gameIdTable(_$AppDatabase db) =>
      db.games.createAlias('game_analyses__game_id__games__id');

  $$GamesTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<int>('game_id')!;

    final manager = $$GamesTableTableManager(
      $_db,
      $_db.games,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GameAnalysesTableFilterComposer
    extends Composer<_$AppDatabase, $GameAnalysesTable> {
  $$GameAnalysesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preset => $composableBuilder(
    column: $table.preset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyWhite => $composableBuilder(
    column: $table.accuracyWhite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyBlack => $composableBuilder(
    column: $table.accuracyBlack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get userAccuracy => $composableBuilder(
    column: $table.userAccuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userInaccuracies => $composableBuilder(
    column: $table.userInaccuracies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userMistakes => $composableBuilder(
    column: $table.userMistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userBlunders => $composableBuilder(
    column: $table.userBlunders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get report => $composableBuilder(
    column: $table.report,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GamesTableFilterComposer get gameId {
    final $$GamesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableFilterComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GameAnalysesTableOrderingComposer
    extends Composer<_$AppDatabase, $GameAnalysesTable> {
  $$GameAnalysesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preset => $composableBuilder(
    column: $table.preset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyWhite => $composableBuilder(
    column: $table.accuracyWhite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyBlack => $composableBuilder(
    column: $table.accuracyBlack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get userAccuracy => $composableBuilder(
    column: $table.userAccuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userInaccuracies => $composableBuilder(
    column: $table.userInaccuracies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userMistakes => $composableBuilder(
    column: $table.userMistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userBlunders => $composableBuilder(
    column: $table.userBlunders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get report => $composableBuilder(
    column: $table.report,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GamesTableOrderingComposer get gameId {
    final $$GamesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableOrderingComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GameAnalysesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameAnalysesTable> {
  $$GameAnalysesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get engine =>
      $composableBuilder(column: $table.engine, builder: (column) => column);

  GeneratedColumn<String> get preset =>
      $composableBuilder(column: $table.preset, builder: (column) => column);

  GeneratedColumn<double> get accuracyWhite => $composableBuilder(
    column: $table.accuracyWhite,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accuracyBlack => $composableBuilder(
    column: $table.accuracyBlack,
    builder: (column) => column,
  );

  GeneratedColumn<double> get userAccuracy => $composableBuilder(
    column: $table.userAccuracy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get userInaccuracies => $composableBuilder(
    column: $table.userInaccuracies,
    builder: (column) => column,
  );

  GeneratedColumn<int> get userMistakes => $composableBuilder(
    column: $table.userMistakes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get userBlunders => $composableBuilder(
    column: $table.userBlunders,
    builder: (column) => column,
  );

  GeneratedColumn<String> get report =>
      $composableBuilder(column: $table.report, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GamesTableAnnotationComposer get gameId {
    final $$GamesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.games,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamesTableAnnotationComposer(
            $db: $db,
            $table: $db.games,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GameAnalysesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameAnalysesTable,
          GameAnalyse,
          $$GameAnalysesTableFilterComposer,
          $$GameAnalysesTableOrderingComposer,
          $$GameAnalysesTableAnnotationComposer,
          $$GameAnalysesTableCreateCompanionBuilder,
          $$GameAnalysesTableUpdateCompanionBuilder,
          (GameAnalyse, $$GameAnalysesTableReferences),
          GameAnalyse,
          PrefetchHooks Function({bool gameId})
        > {
  $$GameAnalysesTableTableManager(_$AppDatabase db, $GameAnalysesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameAnalysesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameAnalysesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameAnalysesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> gameId = const Value.absent(),
                Value<String> engine = const Value.absent(),
                Value<String> preset = const Value.absent(),
                Value<double?> accuracyWhite = const Value.absent(),
                Value<double?> accuracyBlack = const Value.absent(),
                Value<double?> userAccuracy = const Value.absent(),
                Value<int> userInaccuracies = const Value.absent(),
                Value<int> userMistakes = const Value.absent(),
                Value<int> userBlunders = const Value.absent(),
                Value<String> report = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GameAnalysesCompanion(
                gameId: gameId,
                engine: engine,
                preset: preset,
                accuracyWhite: accuracyWhite,
                accuracyBlack: accuracyBlack,
                userAccuracy: userAccuracy,
                userInaccuracies: userInaccuracies,
                userMistakes: userMistakes,
                userBlunders: userBlunders,
                report: report,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> gameId = const Value.absent(),
                required String engine,
                required String preset,
                Value<double?> accuracyWhite = const Value.absent(),
                Value<double?> accuracyBlack = const Value.absent(),
                Value<double?> userAccuracy = const Value.absent(),
                Value<int> userInaccuracies = const Value.absent(),
                Value<int> userMistakes = const Value.absent(),
                Value<int> userBlunders = const Value.absent(),
                required String report,
                required DateTime createdAt,
              }) => GameAnalysesCompanion.insert(
                gameId: gameId,
                engine: engine,
                preset: preset,
                accuracyWhite: accuracyWhite,
                accuracyBlack: accuracyBlack,
                userAccuracy: userAccuracy,
                userInaccuracies: userInaccuracies,
                userMistakes: userMistakes,
                userBlunders: userBlunders,
                report: report,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GameAnalysesTable, GameAnalyse>(table),
                  $$GameAnalysesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gameId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gameId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.gameId,
                        referencedTable: $$GameAnalysesTableReferences
                            ._gameIdTable(db),
                        referencedColumn: $$GameAnalysesTableReferences
                            ._gameIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GameAnalysesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameAnalysesTable,
      GameAnalyse,
      $$GameAnalysesTableFilterComposer,
      $$GameAnalysesTableOrderingComposer,
      $$GameAnalysesTableAnnotationComposer,
      $$GameAnalysesTableCreateCompanionBuilder,
      $$GameAnalysesTableUpdateCompanionBuilder,
      (GameAnalyse, $$GameAnalysesTableReferences),
      GameAnalyse,
      PrefetchHooks Function({bool gameId})
    >;
typedef $$PuzzlesTableCreateCompanionBuilder = PuzzlesCompanion Function({
  required String id,
  required String fen,
  required String moves,
  required int rating,
  Value<int> popularity,
  required String themes,
  required String source,
  Value<String?> packId,
  Value<int?> gameId,
  Value<int?> ply,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$PuzzlesTableUpdateCompanionBuilder = PuzzlesCompanion Function({
  Value<String> id,
  Value<String> fen,
  Value<String> moves,
  Value<int> rating,
  Value<int> popularity,
  Value<String> themes,
  Value<String> source,
  Value<String?> packId,
  Value<int?> gameId,
  Value<int?> ply,
  Value<String?> note,
  Value<int> rowid,
});

class $$PuzzlesTableFilterComposer
    extends Composer<_$AppDatabase, $PuzzlesTable> {
  $$PuzzlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fen => $composableBuilder(
    column: $table.fen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moves => $composableBuilder(
    column: $table.moves,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themes => $composableBuilder(
    column: $table.themes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packId => $composableBuilder(
    column: $table.packId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ply => $composableBuilder(
    column: $table.ply,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PuzzlesTableOrderingComposer
    extends Composer<_$AppDatabase, $PuzzlesTable> {
  $$PuzzlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fen => $composableBuilder(
    column: $table.fen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moves => $composableBuilder(
    column: $table.moves,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themes => $composableBuilder(
    column: $table.themes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packId => $composableBuilder(
    column: $table.packId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ply => $composableBuilder(
    column: $table.ply,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PuzzlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PuzzlesTable> {
  $$PuzzlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fen =>
      $composableBuilder(column: $table.fen, builder: (column) => column);

  GeneratedColumn<String> get moves =>
      $composableBuilder(column: $table.moves, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get popularity => $composableBuilder(
    column: $table.popularity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themes =>
      $composableBuilder(column: $table.themes, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get packId =>
      $composableBuilder(column: $table.packId, builder: (column) => column);

  GeneratedColumn<int> get gameId =>
      $composableBuilder(column: $table.gameId, builder: (column) => column);

  GeneratedColumn<int> get ply =>
      $composableBuilder(column: $table.ply, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$PuzzlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PuzzlesTable,
          PuzzleRow,
          $$PuzzlesTableFilterComposer,
          $$PuzzlesTableOrderingComposer,
          $$PuzzlesTableAnnotationComposer,
          $$PuzzlesTableCreateCompanionBuilder,
          $$PuzzlesTableUpdateCompanionBuilder,
          (PuzzleRow, BaseReferences<_$AppDatabase, $PuzzlesTable, PuzzleRow>),
          PuzzleRow,
          PrefetchHooks Function()
        > {
  $$PuzzlesTableTableManager(_$AppDatabase db, $PuzzlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PuzzlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PuzzlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PuzzlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fen = const Value.absent(),
                Value<String> moves = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<int> popularity = const Value.absent(),
                Value<String> themes = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> packId = const Value.absent(),
                Value<int?> gameId = const Value.absent(),
                Value<int?> ply = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PuzzlesCompanion(
                id: id,
                fen: fen,
                moves: moves,
                rating: rating,
                popularity: popularity,
                themes: themes,
                source: source,
                packId: packId,
                gameId: gameId,
                ply: ply,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fen,
                required String moves,
                required int rating,
                Value<int> popularity = const Value.absent(),
                required String themes,
                required String source,
                Value<String?> packId = const Value.absent(),
                Value<int?> gameId = const Value.absent(),
                Value<int?> ply = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PuzzlesCompanion.insert(
                id: id,
                fen: fen,
                moves: moves,
                rating: rating,
                popularity: popularity,
                themes: themes,
                source: source,
                packId: packId,
                gameId: gameId,
                ply: ply,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PuzzlesTable, PuzzleRow>(table),
                  BaseReferences<_$AppDatabase, $PuzzlesTable, PuzzleRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PuzzlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PuzzlesTable,
      PuzzleRow,
      $$PuzzlesTableFilterComposer,
      $$PuzzlesTableOrderingComposer,
      $$PuzzlesTableAnnotationComposer,
      $$PuzzlesTableCreateCompanionBuilder,
      $$PuzzlesTableUpdateCompanionBuilder,
      (PuzzleRow, BaseReferences<_$AppDatabase, $PuzzlesTable, PuzzleRow>),
      PuzzleRow,
      PrefetchHooks Function()
    >;
typedef $$PuzzlePacksTableCreateCompanionBuilder =
    PuzzlePacksCompanion Function({
      required String id,
      required String theme,
      required int ratingMin,
      required int ratingMax,
      required int count,
      required int bytes,
      required int version,
      required DateTime downloadedAt,
      Value<int> rowid,
    });
typedef $$PuzzlePacksTableUpdateCompanionBuilder =
    PuzzlePacksCompanion Function({
      Value<String> id,
      Value<String> theme,
      Value<int> ratingMin,
      Value<int> ratingMax,
      Value<int> count,
      Value<int> bytes,
      Value<int> version,
      Value<DateTime> downloadedAt,
      Value<int> rowid,
    });

class $$PuzzlePacksTableFilterComposer
    extends Composer<_$AppDatabase, $PuzzlePacksTable> {
  $$PuzzlePacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratingMin => $composableBuilder(
    column: $table.ratingMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratingMax => $composableBuilder(
    column: $table.ratingMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PuzzlePacksTableOrderingComposer
    extends Composer<_$AppDatabase, $PuzzlePacksTable> {
  $$PuzzlePacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratingMin => $composableBuilder(
    column: $table.ratingMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratingMax => $composableBuilder(
    column: $table.ratingMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytes => $composableBuilder(
    column: $table.bytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PuzzlePacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $PuzzlePacksTable> {
  $$PuzzlePacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<int> get ratingMin =>
      $composableBuilder(column: $table.ratingMin, builder: (column) => column);

  GeneratedColumn<int> get ratingMax =>
      $composableBuilder(column: $table.ratingMax, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<int> get bytes =>
      $composableBuilder(column: $table.bytes, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get downloadedAt => $composableBuilder(
    column: $table.downloadedAt,
    builder: (column) => column,
  );
}

class $$PuzzlePacksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PuzzlePacksTable,
          PuzzlePack,
          $$PuzzlePacksTableFilterComposer,
          $$PuzzlePacksTableOrderingComposer,
          $$PuzzlePacksTableAnnotationComposer,
          $$PuzzlePacksTableCreateCompanionBuilder,
          $$PuzzlePacksTableUpdateCompanionBuilder,
          (
            PuzzlePack,
            BaseReferences<_$AppDatabase, $PuzzlePacksTable, PuzzlePack>,
          ),
          PuzzlePack,
          PrefetchHooks Function()
        > {
  $$PuzzlePacksTableTableManager(_$AppDatabase db, $PuzzlePacksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PuzzlePacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PuzzlePacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PuzzlePacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<int> ratingMin = const Value.absent(),
                Value<int> ratingMax = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<int> bytes = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> downloadedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PuzzlePacksCompanion(
                id: id,
                theme: theme,
                ratingMin: ratingMin,
                ratingMax: ratingMax,
                count: count,
                bytes: bytes,
                version: version,
                downloadedAt: downloadedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String theme,
                required int ratingMin,
                required int ratingMax,
                required int count,
                required int bytes,
                required int version,
                required DateTime downloadedAt,
                Value<int> rowid = const Value.absent(),
              }) => PuzzlePacksCompanion.insert(
                id: id,
                theme: theme,
                ratingMin: ratingMin,
                ratingMax: ratingMax,
                count: count,
                bytes: bytes,
                version: version,
                downloadedAt: downloadedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PuzzlePacksTable, PuzzlePack>(table),
                  BaseReferences<_$AppDatabase, $PuzzlePacksTable, PuzzlePack>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PuzzlePacksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PuzzlePacksTable,
      PuzzlePack,
      $$PuzzlePacksTableFilterComposer,
      $$PuzzlePacksTableOrderingComposer,
      $$PuzzlePacksTableAnnotationComposer,
      $$PuzzlePacksTableCreateCompanionBuilder,
      $$PuzzlePacksTableUpdateCompanionBuilder,
      (
        PuzzlePack,
        BaseReferences<_$AppDatabase, $PuzzlePacksTable, PuzzlePack>,
      ),
      PuzzlePack,
      PrefetchHooks Function()
    >;
typedef $$PuzzleAttemptsTableCreateCompanionBuilder =
    PuzzleAttemptsCompanion Function({
      required String id,
      required String puzzleId,
      required bool solved,
      Value<int> hintsUsed,
      required int timeMs,
      required int puzzleRating,
      required double ratingAfter,
      required double rdAfter,
      required double volAfter,
      required DateTime attemptedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$PuzzleAttemptsTableUpdateCompanionBuilder =
    PuzzleAttemptsCompanion Function({
      Value<String> id,
      Value<String> puzzleId,
      Value<bool> solved,
      Value<int> hintsUsed,
      Value<int> timeMs,
      Value<int> puzzleRating,
      Value<double> ratingAfter,
      Value<double> rdAfter,
      Value<double> volAfter,
      Value<DateTime> attemptedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$PuzzleAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $PuzzleAttemptsTable> {
  $$PuzzleAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get solved => $composableBuilder(
    column: $table.solved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get puzzleRating => $composableBuilder(
    column: $table.puzzleRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratingAfter => $composableBuilder(
    column: $table.ratingAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rdAfter => $composableBuilder(
    column: $table.rdAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volAfter => $composableBuilder(
    column: $table.volAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PuzzleAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $PuzzleAttemptsTable> {
  $$PuzzleAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get solved => $composableBuilder(
    column: $table.solved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeMs => $composableBuilder(
    column: $table.timeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get puzzleRating => $composableBuilder(
    column: $table.puzzleRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratingAfter => $composableBuilder(
    column: $table.ratingAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rdAfter => $composableBuilder(
    column: $table.rdAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volAfter => $composableBuilder(
    column: $table.volAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PuzzleAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PuzzleAttemptsTable> {
  $$PuzzleAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get puzzleId =>
      $composableBuilder(column: $table.puzzleId, builder: (column) => column);

  GeneratedColumn<bool> get solved =>
      $composableBuilder(column: $table.solved, builder: (column) => column);

  GeneratedColumn<int> get hintsUsed =>
      $composableBuilder(column: $table.hintsUsed, builder: (column) => column);

  GeneratedColumn<int> get timeMs =>
      $composableBuilder(column: $table.timeMs, builder: (column) => column);

  GeneratedColumn<int> get puzzleRating => $composableBuilder(
    column: $table.puzzleRating,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ratingAfter => $composableBuilder(
    column: $table.ratingAfter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rdAfter =>
      $composableBuilder(column: $table.rdAfter, builder: (column) => column);

  GeneratedColumn<double> get volAfter =>
      $composableBuilder(column: $table.volAfter, builder: (column) => column);

  GeneratedColumn<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$PuzzleAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PuzzleAttemptsTable,
          PuzzleAttempt,
          $$PuzzleAttemptsTableFilterComposer,
          $$PuzzleAttemptsTableOrderingComposer,
          $$PuzzleAttemptsTableAnnotationComposer,
          $$PuzzleAttemptsTableCreateCompanionBuilder,
          $$PuzzleAttemptsTableUpdateCompanionBuilder,
          (
            PuzzleAttempt,
            BaseReferences<_$AppDatabase, $PuzzleAttemptsTable, PuzzleAttempt>,
          ),
          PuzzleAttempt,
          PrefetchHooks Function()
        > {
  $$PuzzleAttemptsTableTableManager(
    _$AppDatabase db,
    $PuzzleAttemptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PuzzleAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PuzzleAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PuzzleAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<bool> solved = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<int> timeMs = const Value.absent(),
                Value<int> puzzleRating = const Value.absent(),
                Value<double> ratingAfter = const Value.absent(),
                Value<double> rdAfter = const Value.absent(),
                Value<double> volAfter = const Value.absent(),
                Value<DateTime> attemptedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PuzzleAttemptsCompanion(
                id: id,
                puzzleId: puzzleId,
                solved: solved,
                hintsUsed: hintsUsed,
                timeMs: timeMs,
                puzzleRating: puzzleRating,
                ratingAfter: ratingAfter,
                rdAfter: rdAfter,
                volAfter: volAfter,
                attemptedAt: attemptedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String puzzleId,
                required bool solved,
                Value<int> hintsUsed = const Value.absent(),
                required int timeMs,
                required int puzzleRating,
                required double ratingAfter,
                required double rdAfter,
                required double volAfter,
                required DateTime attemptedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PuzzleAttemptsCompanion.insert(
                id: id,
                puzzleId: puzzleId,
                solved: solved,
                hintsUsed: hintsUsed,
                timeMs: timeMs,
                puzzleRating: puzzleRating,
                ratingAfter: ratingAfter,
                rdAfter: rdAfter,
                volAfter: volAfter,
                attemptedAt: attemptedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PuzzleAttemptsTable, PuzzleAttempt>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PuzzleAttemptsTable,
                    PuzzleAttempt
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PuzzleAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PuzzleAttemptsTable,
      PuzzleAttempt,
      $$PuzzleAttemptsTableFilterComposer,
      $$PuzzleAttemptsTableOrderingComposer,
      $$PuzzleAttemptsTableAnnotationComposer,
      $$PuzzleAttemptsTableCreateCompanionBuilder,
      $$PuzzleAttemptsTableUpdateCompanionBuilder,
      (
        PuzzleAttempt,
        BaseReferences<_$AppDatabase, $PuzzleAttemptsTable, PuzzleAttempt>,
      ),
      PuzzleAttempt,
      PrefetchHooks Function()
    >;
typedef $$VisionSessionsTableCreateCompanionBuilder =
    VisionSessionsCompanion Function({
      required String id,
      required String mode,
      required String side,
      required bool coords,
      required int score,
      required int errors,
      required int durationMs,
      required String misses,
      required DateTime startedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$VisionSessionsTableUpdateCompanionBuilder =
    VisionSessionsCompanion Function({
      Value<String> id,
      Value<String> mode,
      Value<String> side,
      Value<bool> coords,
      Value<int> score,
      Value<int> errors,
      Value<int> durationMs,
      Value<String> misses,
      Value<DateTime> startedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$VisionSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $VisionSessionsTable> {
  $$VisionSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get coords => $composableBuilder(
    column: $table.coords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get errors => $composableBuilder(
    column: $table.errors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get misses => $composableBuilder(
    column: $table.misses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VisionSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $VisionSessionsTable> {
  $$VisionSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get coords => $composableBuilder(
    column: $table.coords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get errors => $composableBuilder(
    column: $table.errors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get misses => $composableBuilder(
    column: $table.misses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VisionSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisionSessionsTable> {
  $$VisionSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get side =>
      $composableBuilder(column: $table.side, builder: (column) => column);

  GeneratedColumn<bool> get coords =>
      $composableBuilder(column: $table.coords, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get errors =>
      $composableBuilder(column: $table.errors, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get misses =>
      $composableBuilder(column: $table.misses, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$VisionSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VisionSessionsTable,
          VisionSession,
          $$VisionSessionsTableFilterComposer,
          $$VisionSessionsTableOrderingComposer,
          $$VisionSessionsTableAnnotationComposer,
          $$VisionSessionsTableCreateCompanionBuilder,
          $$VisionSessionsTableUpdateCompanionBuilder,
          (
            VisionSession,
            BaseReferences<_$AppDatabase, $VisionSessionsTable, VisionSession>,
          ),
          VisionSession,
          PrefetchHooks Function()
        > {
  $$VisionSessionsTableTableManager(
    _$AppDatabase db,
    $VisionSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisionSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisionSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VisionSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> side = const Value.absent(),
                Value<bool> coords = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> errors = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<String> misses = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VisionSessionsCompanion(
                id: id,
                mode: mode,
                side: side,
                coords: coords,
                score: score,
                errors: errors,
                durationMs: durationMs,
                misses: misses,
                startedAt: startedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mode,
                required String side,
                required bool coords,
                required int score,
                required int errors,
                required int durationMs,
                required String misses,
                required DateTime startedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VisionSessionsCompanion.insert(
                id: id,
                mode: mode,
                side: side,
                coords: coords,
                score: score,
                errors: errors,
                durationMs: durationMs,
                misses: misses,
                startedAt: startedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VisionSessionsTable, VisionSession>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $VisionSessionsTable,
                    VisionSession
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VisionSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VisionSessionsTable,
      VisionSession,
      $$VisionSessionsTableFilterComposer,
      $$VisionSessionsTableOrderingComposer,
      $$VisionSessionsTableAnnotationComposer,
      $$VisionSessionsTableCreateCompanionBuilder,
      $$VisionSessionsTableUpdateCompanionBuilder,
      (
        VisionSession,
        BaseReferences<_$AppDatabase, $VisionSessionsTable, VisionSession>,
      ),
      VisionSession,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GamesTableTableManager get games =>
      $$GamesTableTableManager(_db, _db.games);
  $$PositionEvalsTableTableManager get positionEvals =>
      $$PositionEvalsTableTableManager(_db, _db.positionEvals);
  $$GameAnalysesTableTableManager get gameAnalyses =>
      $$GameAnalysesTableTableManager(_db, _db.gameAnalyses);
  $$PuzzlesTableTableManager get puzzles =>
      $$PuzzlesTableTableManager(_db, _db.puzzles);
  $$PuzzlePacksTableTableManager get puzzlePacks =>
      $$PuzzlePacksTableTableManager(_db, _db.puzzlePacks);
  $$PuzzleAttemptsTableTableManager get puzzleAttempts =>
      $$PuzzleAttemptsTableTableManager(_db, _db.puzzleAttempts);
  $$VisionSessionsTableTableManager get visionSessions =>
      $$VisionSessionsTableTableManager(_db, _db.visionSessions);
}
