// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $QuizTable extends Quiz with TableInfo<$QuizTable, QuizData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<int> length = GeneratedColumn<int>(
      'length', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, length];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz';
  @override
  VerificationContext validateIntegrity(Insertable<QuizData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length']!, _lengthMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      length: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}length']),
    );
  }

  @override
  $QuizTable createAlias(String alias) {
    return $QuizTable(attachedDatabase, alias);
  }
}

class QuizData extends DataClass implements Insertable<QuizData> {
  final int id;
  final String name;
  final int? length;
  const QuizData({required this.id, required this.name, this.length});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || length != null) {
      map['length'] = Variable<int>(length);
    }
    return map;
  }

  QuizCompanion toCompanion(bool nullToAbsent) {
    return QuizCompanion(
      id: Value(id),
      name: Value(name),
      length:
          length == null && nullToAbsent ? const Value.absent() : Value(length),
    );
  }

  factory QuizData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      length: serializer.fromJson<int?>(json['length']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'length': serializer.toJson<int?>(length),
    };
  }

  QuizData copyWith(
          {int? id, String? name, Value<int?> length = const Value.absent()}) =>
      QuizData(
        id: id ?? this.id,
        name: name ?? this.name,
        length: length.present ? length.value : this.length,
      );
  QuizData copyWithCompanion(QuizCompanion data) {
    return QuizData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      length: data.length.present ? data.length.value : this.length,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('length: $length')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, length);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizData &&
          other.id == this.id &&
          other.name == this.name &&
          other.length == this.length);
}

class QuizCompanion extends UpdateCompanion<QuizData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> length;
  const QuizCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.length = const Value.absent(),
  });
  QuizCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.length = const Value.absent(),
  }) : name = Value(name);
  static Insertable<QuizData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? length,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (length != null) 'length': length,
    });
  }

  QuizCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int?>? length}) {
    return QuizCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      length: length ?? this.length,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (length.present) {
      map['length'] = Variable<int>(length.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('length: $length')
          ..write(')'))
        .toString();
  }
}

class $QuestionTable extends Question
    with TableInfo<$QuestionTable, QuestionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<int> quizId = GeneratedColumn<int>(
      'quiz_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES quiz (id) ON UPDATE CASCADE ON DELETE CASCADE'));
  static const VerificationMeta _questionMeta =
      const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
      'question', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _variantsMeta =
      const VerificationMeta('variants');
  @override
  late final GeneratedColumn<String> variants = GeneratedColumn<String>(
      'variants', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, quizId, question, variants];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quiz_id')) {
      context.handle(_quizIdMeta,
          quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta));
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('variants')) {
      context.handle(_variantsMeta,
          variants.isAcceptableOrUnknown(data['variants']!, _variantsMeta));
    } else if (isInserting) {
      context.missing(_variantsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      quizId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quiz_id'])!,
      question: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      variants: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variants'])!,
    );
  }

  @override
  $QuestionTable createAlias(String alias) {
    return $QuestionTable(attachedDatabase, alias);
  }
}

class QuestionData extends DataClass implements Insertable<QuestionData> {
  final int id;
  final int quizId;
  final String question;
  final String variants;
  const QuestionData(
      {required this.id,
      required this.quizId,
      required this.question,
      required this.variants});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quiz_id'] = Variable<int>(quizId);
    map['question'] = Variable<String>(question);
    map['variants'] = Variable<String>(variants);
    return map;
  }

  QuestionCompanion toCompanion(bool nullToAbsent) {
    return QuestionCompanion(
      id: Value(id),
      quizId: Value(quizId),
      question: Value(question),
      variants: Value(variants),
    );
  }

  factory QuestionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionData(
      id: serializer.fromJson<int>(json['id']),
      quizId: serializer.fromJson<int>(json['quizId']),
      question: serializer.fromJson<String>(json['question']),
      variants: serializer.fromJson<String>(json['variants']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quizId': serializer.toJson<int>(quizId),
      'question': serializer.toJson<String>(question),
      'variants': serializer.toJson<String>(variants),
    };
  }

  QuestionData copyWith(
          {int? id, int? quizId, String? question, String? variants}) =>
      QuestionData(
        id: id ?? this.id,
        quizId: quizId ?? this.quizId,
        question: question ?? this.question,
        variants: variants ?? this.variants,
      );
  QuestionData copyWithCompanion(QuestionCompanion data) {
    return QuestionData(
      id: data.id.present ? data.id.value : this.id,
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      question: data.question.present ? data.question.value : this.question,
      variants: data.variants.present ? data.variants.value : this.variants,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionData(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('question: $question, ')
          ..write('variants: $variants')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, quizId, question, variants);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionData &&
          other.id == this.id &&
          other.quizId == this.quizId &&
          other.question == this.question &&
          other.variants == this.variants);
}

class QuestionCompanion extends UpdateCompanion<QuestionData> {
  final Value<int> id;
  final Value<int> quizId;
  final Value<String> question;
  final Value<String> variants;
  const QuestionCompanion({
    this.id = const Value.absent(),
    this.quizId = const Value.absent(),
    this.question = const Value.absent(),
    this.variants = const Value.absent(),
  });
  QuestionCompanion.insert({
    this.id = const Value.absent(),
    required int quizId,
    required String question,
    required String variants,
  })  : quizId = Value(quizId),
        question = Value(question),
        variants = Value(variants);
  static Insertable<QuestionData> custom({
    Expression<int>? id,
    Expression<int>? quizId,
    Expression<String>? question,
    Expression<String>? variants,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quizId != null) 'quiz_id': quizId,
      if (question != null) 'question': question,
      if (variants != null) 'variants': variants,
    });
  }

  QuestionCompanion copyWith(
      {Value<int>? id,
      Value<int>? quizId,
      Value<String>? question,
      Value<String>? variants}) {
    return QuestionCompanion(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      question: question ?? this.question,
      variants: variants ?? this.variants,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quizId.present) {
      map['quiz_id'] = Variable<int>(quizId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (variants.present) {
      map['variants'] = Variable<String>(variants.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionCompanion(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('question: $question, ')
          ..write('variants: $variants')
          ..write(')'))
        .toString();
  }
}

class $StatisticTable extends Statistic
    with TableInfo<$StatisticTable, StatisticData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatisticTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<int> quizId = GeneratedColumn<int>(
      'quiz_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES quiz (id) ON UPDATE CASCADE ON DELETE CASCADE'));
  static const VerificationMeta _playCountMeta =
      const VerificationMeta('playCount');
  @override
  late final GeneratedColumn<int> playCount = GeneratedColumn<int>(
      'play_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _highestScoreMeta =
      const VerificationMeta('highestScore');
  @override
  late final GeneratedColumn<int> highestScore = GeneratedColumn<int>(
      'highest_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lowestScoreMeta =
      const VerificationMeta('lowestScore');
  @override
  late final GeneratedColumn<int> lowestScore = GeneratedColumn<int>(
      'lowest_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _avgScoreMeta =
      const VerificationMeta('avgScore');
  @override
  late final GeneratedColumn<double> avgScore = GeneratedColumn<double>(
      'avg_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, quizId, playCount, highestScore, lowestScore, avgScore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'statistic';
  @override
  VerificationContext validateIntegrity(Insertable<StatisticData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quiz_id')) {
      context.handle(_quizIdMeta,
          quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta));
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('play_count')) {
      context.handle(_playCountMeta,
          playCount.isAcceptableOrUnknown(data['play_count']!, _playCountMeta));
    } else if (isInserting) {
      context.missing(_playCountMeta);
    }
    if (data.containsKey('highest_score')) {
      context.handle(
          _highestScoreMeta,
          highestScore.isAcceptableOrUnknown(
              data['highest_score']!, _highestScoreMeta));
    } else if (isInserting) {
      context.missing(_highestScoreMeta);
    }
    if (data.containsKey('lowest_score')) {
      context.handle(
          _lowestScoreMeta,
          lowestScore.isAcceptableOrUnknown(
              data['lowest_score']!, _lowestScoreMeta));
    } else if (isInserting) {
      context.missing(_lowestScoreMeta);
    }
    if (data.containsKey('avg_score')) {
      context.handle(_avgScoreMeta,
          avgScore.isAcceptableOrUnknown(data['avg_score']!, _avgScoreMeta));
    } else if (isInserting) {
      context.missing(_avgScoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatisticData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatisticData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      quizId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quiz_id'])!,
      playCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}play_count'])!,
      highestScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}highest_score'])!,
      lowestScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lowest_score'])!,
      avgScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}avg_score'])!,
    );
  }

  @override
  $StatisticTable createAlias(String alias) {
    return $StatisticTable(attachedDatabase, alias);
  }
}

class StatisticData extends DataClass implements Insertable<StatisticData> {
  final int id;
  final int quizId;
  final int playCount;
  final int highestScore;
  final int lowestScore;
  final double avgScore;
  const StatisticData(
      {required this.id,
      required this.quizId,
      required this.playCount,
      required this.highestScore,
      required this.lowestScore,
      required this.avgScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quiz_id'] = Variable<int>(quizId);
    map['play_count'] = Variable<int>(playCount);
    map['highest_score'] = Variable<int>(highestScore);
    map['lowest_score'] = Variable<int>(lowestScore);
    map['avg_score'] = Variable<double>(avgScore);
    return map;
  }

  StatisticCompanion toCompanion(bool nullToAbsent) {
    return StatisticCompanion(
      id: Value(id),
      quizId: Value(quizId),
      playCount: Value(playCount),
      highestScore: Value(highestScore),
      lowestScore: Value(lowestScore),
      avgScore: Value(avgScore),
    );
  }

  factory StatisticData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatisticData(
      id: serializer.fromJson<int>(json['id']),
      quizId: serializer.fromJson<int>(json['quizId']),
      playCount: serializer.fromJson<int>(json['playCount']),
      highestScore: serializer.fromJson<int>(json['highestScore']),
      lowestScore: serializer.fromJson<int>(json['lowestScore']),
      avgScore: serializer.fromJson<double>(json['avgScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quizId': serializer.toJson<int>(quizId),
      'playCount': serializer.toJson<int>(playCount),
      'highestScore': serializer.toJson<int>(highestScore),
      'lowestScore': serializer.toJson<int>(lowestScore),
      'avgScore': serializer.toJson<double>(avgScore),
    };
  }

  StatisticData copyWith(
          {int? id,
          int? quizId,
          int? playCount,
          int? highestScore,
          int? lowestScore,
          double? avgScore}) =>
      StatisticData(
        id: id ?? this.id,
        quizId: quizId ?? this.quizId,
        playCount: playCount ?? this.playCount,
        highestScore: highestScore ?? this.highestScore,
        lowestScore: lowestScore ?? this.lowestScore,
        avgScore: avgScore ?? this.avgScore,
      );
  StatisticData copyWithCompanion(StatisticCompanion data) {
    return StatisticData(
      id: data.id.present ? data.id.value : this.id,
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      playCount: data.playCount.present ? data.playCount.value : this.playCount,
      highestScore: data.highestScore.present
          ? data.highestScore.value
          : this.highestScore,
      lowestScore:
          data.lowestScore.present ? data.lowestScore.value : this.lowestScore,
      avgScore: data.avgScore.present ? data.avgScore.value : this.avgScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatisticData(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('playCount: $playCount, ')
          ..write('highestScore: $highestScore, ')
          ..write('lowestScore: $lowestScore, ')
          ..write('avgScore: $avgScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, quizId, playCount, highestScore, lowestScore, avgScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatisticData &&
          other.id == this.id &&
          other.quizId == this.quizId &&
          other.playCount == this.playCount &&
          other.highestScore == this.highestScore &&
          other.lowestScore == this.lowestScore &&
          other.avgScore == this.avgScore);
}

class StatisticCompanion extends UpdateCompanion<StatisticData> {
  final Value<int> id;
  final Value<int> quizId;
  final Value<int> playCount;
  final Value<int> highestScore;
  final Value<int> lowestScore;
  final Value<double> avgScore;
  const StatisticCompanion({
    this.id = const Value.absent(),
    this.quizId = const Value.absent(),
    this.playCount = const Value.absent(),
    this.highestScore = const Value.absent(),
    this.lowestScore = const Value.absent(),
    this.avgScore = const Value.absent(),
  });
  StatisticCompanion.insert({
    this.id = const Value.absent(),
    required int quizId,
    required int playCount,
    required int highestScore,
    required int lowestScore,
    required double avgScore,
  })  : quizId = Value(quizId),
        playCount = Value(playCount),
        highestScore = Value(highestScore),
        lowestScore = Value(lowestScore),
        avgScore = Value(avgScore);
  static Insertable<StatisticData> custom({
    Expression<int>? id,
    Expression<int>? quizId,
    Expression<int>? playCount,
    Expression<int>? highestScore,
    Expression<int>? lowestScore,
    Expression<double>? avgScore,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quizId != null) 'quiz_id': quizId,
      if (playCount != null) 'play_count': playCount,
      if (highestScore != null) 'highest_score': highestScore,
      if (lowestScore != null) 'lowest_score': lowestScore,
      if (avgScore != null) 'avg_score': avgScore,
    });
  }

  StatisticCompanion copyWith(
      {Value<int>? id,
      Value<int>? quizId,
      Value<int>? playCount,
      Value<int>? highestScore,
      Value<int>? lowestScore,
      Value<double>? avgScore}) {
    return StatisticCompanion(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      playCount: playCount ?? this.playCount,
      highestScore: highestScore ?? this.highestScore,
      lowestScore: lowestScore ?? this.lowestScore,
      avgScore: avgScore ?? this.avgScore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quizId.present) {
      map['quiz_id'] = Variable<int>(quizId.value);
    }
    if (playCount.present) {
      map['play_count'] = Variable<int>(playCount.value);
    }
    if (highestScore.present) {
      map['highest_score'] = Variable<int>(highestScore.value);
    }
    if (lowestScore.present) {
      map['lowest_score'] = Variable<int>(lowestScore.value);
    }
    if (avgScore.present) {
      map['avg_score'] = Variable<double>(avgScore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatisticCompanion(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('playCount: $playCount, ')
          ..write('highestScore: $highestScore, ')
          ..write('lowestScore: $lowestScore, ')
          ..write('avgScore: $avgScore')
          ..write(')'))
        .toString();
  }
}

class $CompletedQuizTable extends CompletedQuiz
    with TableInfo<$CompletedQuizTable, CompletedQuizData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletedQuizTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<int> quizId = GeneratedColumn<int>(
      'quiz_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES quiz (id) ON UPDATE CASCADE ON DELETE CASCADE'));
  static const VerificationMeta _questionCountMeta =
      const VerificationMeta('questionCount');
  @override
  late final GeneratedColumn<int> questionCount = GeneratedColumn<int>(
      'question_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rightQuestionsMeta =
      const VerificationMeta('rightQuestions');
  @override
  late final GeneratedColumn<int> rightQuestions = GeneratedColumn<int>(
      'right_questions', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _playedAtMeta =
      const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
      'played_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, quizId, questionCount, rightQuestions, playedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completed_quiz';
  @override
  VerificationContext validateIntegrity(Insertable<CompletedQuizData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quiz_id')) {
      context.handle(_quizIdMeta,
          quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta));
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('question_count')) {
      context.handle(
          _questionCountMeta,
          questionCount.isAcceptableOrUnknown(
              data['question_count']!, _questionCountMeta));
    } else if (isInserting) {
      context.missing(_questionCountMeta);
    }
    if (data.containsKey('right_questions')) {
      context.handle(
          _rightQuestionsMeta,
          rightQuestions.isAcceptableOrUnknown(
              data['right_questions']!, _rightQuestionsMeta));
    } else if (isInserting) {
      context.missing(_rightQuestionsMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(_playedAtMeta,
          playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompletedQuizData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedQuizData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      quizId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quiz_id'])!,
      questionCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_count'])!,
      rightQuestions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}right_questions'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
    );
  }

  @override
  $CompletedQuizTable createAlias(String alias) {
    return $CompletedQuizTable(attachedDatabase, alias);
  }
}

class CompletedQuizData extends DataClass
    implements Insertable<CompletedQuizData> {
  final int id;
  final int quizId;
  final int questionCount;
  final int rightQuestions;
  final DateTime playedAt;
  const CompletedQuizData(
      {required this.id,
      required this.quizId,
      required this.questionCount,
      required this.rightQuestions,
      required this.playedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quiz_id'] = Variable<int>(quizId);
    map['question_count'] = Variable<int>(questionCount);
    map['right_questions'] = Variable<int>(rightQuestions);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  CompletedQuizCompanion toCompanion(bool nullToAbsent) {
    return CompletedQuizCompanion(
      id: Value(id),
      quizId: Value(quizId),
      questionCount: Value(questionCount),
      rightQuestions: Value(rightQuestions),
      playedAt: Value(playedAt),
    );
  }

  factory CompletedQuizData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletedQuizData(
      id: serializer.fromJson<int>(json['id']),
      quizId: serializer.fromJson<int>(json['quizId']),
      questionCount: serializer.fromJson<int>(json['questionCount']),
      rightQuestions: serializer.fromJson<int>(json['rightQuestions']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quizId': serializer.toJson<int>(quizId),
      'questionCount': serializer.toJson<int>(questionCount),
      'rightQuestions': serializer.toJson<int>(rightQuestions),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  CompletedQuizData copyWith(
          {int? id,
          int? quizId,
          int? questionCount,
          int? rightQuestions,
          DateTime? playedAt}) =>
      CompletedQuizData(
        id: id ?? this.id,
        quizId: quizId ?? this.quizId,
        questionCount: questionCount ?? this.questionCount,
        rightQuestions: rightQuestions ?? this.rightQuestions,
        playedAt: playedAt ?? this.playedAt,
      );
  CompletedQuizData copyWithCompanion(CompletedQuizCompanion data) {
    return CompletedQuizData(
      id: data.id.present ? data.id.value : this.id,
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      questionCount: data.questionCount.present
          ? data.questionCount.value
          : this.questionCount,
      rightQuestions: data.rightQuestions.present
          ? data.rightQuestions.value
          : this.rightQuestions,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletedQuizData(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('questionCount: $questionCount, ')
          ..write('rightQuestions: $rightQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, quizId, questionCount, rightQuestions, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedQuizData &&
          other.id == this.id &&
          other.quizId == this.quizId &&
          other.questionCount == this.questionCount &&
          other.rightQuestions == this.rightQuestions &&
          other.playedAt == this.playedAt);
}

class CompletedQuizCompanion extends UpdateCompanion<CompletedQuizData> {
  final Value<int> id;
  final Value<int> quizId;
  final Value<int> questionCount;
  final Value<int> rightQuestions;
  final Value<DateTime> playedAt;
  const CompletedQuizCompanion({
    this.id = const Value.absent(),
    this.quizId = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.rightQuestions = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  CompletedQuizCompanion.insert({
    this.id = const Value.absent(),
    required int quizId,
    required int questionCount,
    required int rightQuestions,
    this.playedAt = const Value.absent(),
  })  : quizId = Value(quizId),
        questionCount = Value(questionCount),
        rightQuestions = Value(rightQuestions);
  static Insertable<CompletedQuizData> custom({
    Expression<int>? id,
    Expression<int>? quizId,
    Expression<int>? questionCount,
    Expression<int>? rightQuestions,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quizId != null) 'quiz_id': quizId,
      if (questionCount != null) 'question_count': questionCount,
      if (rightQuestions != null) 'right_questions': rightQuestions,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  CompletedQuizCompanion copyWith(
      {Value<int>? id,
      Value<int>? quizId,
      Value<int>? questionCount,
      Value<int>? rightQuestions,
      Value<DateTime>? playedAt}) {
    return CompletedQuizCompanion(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      questionCount: questionCount ?? this.questionCount,
      rightQuestions: rightQuestions ?? this.rightQuestions,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quizId.present) {
      map['quiz_id'] = Variable<int>(quizId.value);
    }
    if (questionCount.present) {
      map['question_count'] = Variable<int>(questionCount.value);
    }
    if (rightQuestions.present) {
      map['right_questions'] = Variable<int>(rightQuestions.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletedQuizCompanion(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('questionCount: $questionCount, ')
          ..write('rightQuestions: $rightQuestions, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuizTable quiz = $QuizTable(this);
  late final $QuestionTable question = $QuestionTable(this);
  late final $StatisticTable statistic = $StatisticTable(this);
  late final $CompletedQuizTable completedQuiz = $CompletedQuizTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [quiz, question, statistic, completedQuiz];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('quiz',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('question', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quiz',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('question', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quiz',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('statistic', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quiz',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('statistic', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quiz',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('completed_quiz', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('quiz',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('completed_quiz', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $$QuizTableCreateCompanionBuilder = QuizCompanion Function({
  Value<int> id,
  required String name,
  Value<int?> length,
});
typedef $$QuizTableUpdateCompanionBuilder = QuizCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int?> length,
});

final class $$QuizTableReferences
    extends BaseReferences<_$AppDatabase, $QuizTable, QuizData> {
  $$QuizTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuestionTable, List<QuestionData>>
      _questionRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.question,
              aliasName: $_aliasNameGenerator(db.quiz.id, db.question.quizId));

  $$QuestionTableProcessedTableManager get questionRefs {
    final manager = $$QuestionTableTableManager($_db, $_db.question)
        .filter((f) => f.quizId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_questionRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StatisticTable, List<StatisticData>>
      _statisticRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.statistic,
              aliasName: $_aliasNameGenerator(db.quiz.id, db.statistic.quizId));

  $$StatisticTableProcessedTableManager get statisticRefs {
    final manager = $$StatisticTableTableManager($_db, $_db.statistic)
        .filter((f) => f.quizId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_statisticRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CompletedQuizTable, List<CompletedQuizData>>
      _completedQuizRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.completedQuiz,
              aliasName:
                  $_aliasNameGenerator(db.quiz.id, db.completedQuiz.quizId));

  $$CompletedQuizTableProcessedTableManager get completedQuizRefs {
    final manager = $$CompletedQuizTableTableManager($_db, $_db.completedQuiz)
        .filter((f) => f.quizId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_completedQuizRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QuizTableFilterComposer extends Composer<_$AppDatabase, $QuizTable> {
  $$QuizTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get length => $composableBuilder(
      column: $table.length, builder: (column) => ColumnFilters(column));

  Expression<bool> questionRefs(
      Expression<bool> Function($$QuestionTableFilterComposer f) f) {
    final $$QuestionTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.question,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionTableFilterComposer(
              $db: $db,
              $table: $db.question,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> statisticRefs(
      Expression<bool> Function($$StatisticTableFilterComposer f) f) {
    final $$StatisticTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.statistic,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StatisticTableFilterComposer(
              $db: $db,
              $table: $db.statistic,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> completedQuizRefs(
      Expression<bool> Function($$CompletedQuizTableFilterComposer f) f) {
    final $$CompletedQuizTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.completedQuiz,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompletedQuizTableFilterComposer(
              $db: $db,
              $table: $db.completedQuiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuizTableOrderingComposer extends Composer<_$AppDatabase, $QuizTable> {
  $$QuizTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get length => $composableBuilder(
      column: $table.length, builder: (column) => ColumnOrderings(column));
}

class $$QuizTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizTable> {
  $$QuizTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get length =>
      $composableBuilder(column: $table.length, builder: (column) => column);

  Expression<T> questionRefs<T extends Object>(
      Expression<T> Function($$QuestionTableAnnotationComposer a) f) {
    final $$QuestionTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.question,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionTableAnnotationComposer(
              $db: $db,
              $table: $db.question,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> statisticRefs<T extends Object>(
      Expression<T> Function($$StatisticTableAnnotationComposer a) f) {
    final $$StatisticTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.statistic,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StatisticTableAnnotationComposer(
              $db: $db,
              $table: $db.statistic,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> completedQuizRefs<T extends Object>(
      Expression<T> Function($$CompletedQuizTableAnnotationComposer a) f) {
    final $$CompletedQuizTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.completedQuiz,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompletedQuizTableAnnotationComposer(
              $db: $db,
              $table: $db.completedQuiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuizTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuizTable,
    QuizData,
    $$QuizTableFilterComposer,
    $$QuizTableOrderingComposer,
    $$QuizTableAnnotationComposer,
    $$QuizTableCreateCompanionBuilder,
    $$QuizTableUpdateCompanionBuilder,
    (QuizData, $$QuizTableReferences),
    QuizData,
    PrefetchHooks Function(
        {bool questionRefs, bool statisticRefs, bool completedQuizRefs})> {
  $$QuizTableTableManager(_$AppDatabase db, $QuizTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int?> length = const Value.absent(),
          }) =>
              QuizCompanion(
            id: id,
            name: name,
            length: length,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int?> length = const Value.absent(),
          }) =>
              QuizCompanion.insert(
            id: id,
            name: name,
            length: length,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$QuizTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {questionRefs = false,
              statisticRefs = false,
              completedQuizRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (questionRefs) db.question,
                if (statisticRefs) db.statistic,
                if (completedQuizRefs) db.completedQuiz
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (questionRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$QuizTableReferences._questionRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuizTableReferences(db, table, p0).questionRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.quizId == item.id),
                        typedResults: items),
                  if (statisticRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$QuizTableReferences._statisticRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuizTableReferences(db, table, p0).statisticRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.quizId == item.id),
                        typedResults: items),
                  if (completedQuizRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$QuizTableReferences._completedQuizRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuizTableReferences(db, table, p0)
                                .completedQuizRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.quizId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QuizTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuizTable,
    QuizData,
    $$QuizTableFilterComposer,
    $$QuizTableOrderingComposer,
    $$QuizTableAnnotationComposer,
    $$QuizTableCreateCompanionBuilder,
    $$QuizTableUpdateCompanionBuilder,
    (QuizData, $$QuizTableReferences),
    QuizData,
    PrefetchHooks Function(
        {bool questionRefs, bool statisticRefs, bool completedQuizRefs})>;
typedef $$QuestionTableCreateCompanionBuilder = QuestionCompanion Function({
  Value<int> id,
  required int quizId,
  required String question,
  required String variants,
});
typedef $$QuestionTableUpdateCompanionBuilder = QuestionCompanion Function({
  Value<int> id,
  Value<int> quizId,
  Value<String> question,
  Value<String> variants,
});

final class $$QuestionTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionTable, QuestionData> {
  $$QuestionTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuizTable _quizIdTable(_$AppDatabase db) =>
      db.quiz.createAlias($_aliasNameGenerator(db.question.quizId, db.quiz.id));

  $$QuizTableProcessedTableManager get quizId {
    final manager = $$QuizTableTableManager($_db, $_db.quiz)
        .filter((f) => f.id($_item.quizId!));
    final item = $_typedResult.readTableOrNull(_quizIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuestionTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionTable> {
  $$QuestionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variants => $composableBuilder(
      column: $table.variants, builder: (column) => ColumnFilters(column));

  $$QuizTableFilterComposer get quizId {
    final $$QuizTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableFilterComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionTable> {
  $$QuestionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variants => $composableBuilder(
      column: $table.variants, builder: (column) => ColumnOrderings(column));

  $$QuizTableOrderingComposer get quizId {
    final $$QuizTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableOrderingComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionTable> {
  $$QuestionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get variants =>
      $composableBuilder(column: $table.variants, builder: (column) => column);

  $$QuizTableAnnotationComposer get quizId {
    final $$QuizTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableAnnotationComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionTable,
    QuestionData,
    $$QuestionTableFilterComposer,
    $$QuestionTableOrderingComposer,
    $$QuestionTableAnnotationComposer,
    $$QuestionTableCreateCompanionBuilder,
    $$QuestionTableUpdateCompanionBuilder,
    (QuestionData, $$QuestionTableReferences),
    QuestionData,
    PrefetchHooks Function({bool quizId})> {
  $$QuestionTableTableManager(_$AppDatabase db, $QuestionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> quizId = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> variants = const Value.absent(),
          }) =>
              QuestionCompanion(
            id: id,
            quizId: quizId,
            question: question,
            variants: variants,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int quizId,
            required String question,
            required String variants,
          }) =>
              QuestionCompanion.insert(
            id: id,
            quizId: quizId,
            question: question,
            variants: variants,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$QuestionTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({quizId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (quizId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.quizId,
                    referencedTable: $$QuestionTableReferences._quizIdTable(db),
                    referencedColumn:
                        $$QuestionTableReferences._quizIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QuestionTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionTable,
    QuestionData,
    $$QuestionTableFilterComposer,
    $$QuestionTableOrderingComposer,
    $$QuestionTableAnnotationComposer,
    $$QuestionTableCreateCompanionBuilder,
    $$QuestionTableUpdateCompanionBuilder,
    (QuestionData, $$QuestionTableReferences),
    QuestionData,
    PrefetchHooks Function({bool quizId})>;
typedef $$StatisticTableCreateCompanionBuilder = StatisticCompanion Function({
  Value<int> id,
  required int quizId,
  required int playCount,
  required int highestScore,
  required int lowestScore,
  required double avgScore,
});
typedef $$StatisticTableUpdateCompanionBuilder = StatisticCompanion Function({
  Value<int> id,
  Value<int> quizId,
  Value<int> playCount,
  Value<int> highestScore,
  Value<int> lowestScore,
  Value<double> avgScore,
});

final class $$StatisticTableReferences
    extends BaseReferences<_$AppDatabase, $StatisticTable, StatisticData> {
  $$StatisticTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuizTable _quizIdTable(_$AppDatabase db) => db.quiz
      .createAlias($_aliasNameGenerator(db.statistic.quizId, db.quiz.id));

  $$QuizTableProcessedTableManager get quizId {
    final manager = $$QuizTableTableManager($_db, $_db.quiz)
        .filter((f) => f.id($_item.quizId!));
    final item = $_typedResult.readTableOrNull(_quizIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StatisticTableFilterComposer
    extends Composer<_$AppDatabase, $StatisticTable> {
  $$StatisticTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get highestScore => $composableBuilder(
      column: $table.highestScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lowestScore => $composableBuilder(
      column: $table.lowestScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get avgScore => $composableBuilder(
      column: $table.avgScore, builder: (column) => ColumnFilters(column));

  $$QuizTableFilterComposer get quizId {
    final $$QuizTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableFilterComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StatisticTableOrderingComposer
    extends Composer<_$AppDatabase, $StatisticTable> {
  $$StatisticTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get highestScore => $composableBuilder(
      column: $table.highestScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lowestScore => $composableBuilder(
      column: $table.lowestScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get avgScore => $composableBuilder(
      column: $table.avgScore, builder: (column) => ColumnOrderings(column));

  $$QuizTableOrderingComposer get quizId {
    final $$QuizTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableOrderingComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StatisticTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatisticTable> {
  $$StatisticTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get playCount =>
      $composableBuilder(column: $table.playCount, builder: (column) => column);

  GeneratedColumn<int> get highestScore => $composableBuilder(
      column: $table.highestScore, builder: (column) => column);

  GeneratedColumn<int> get lowestScore => $composableBuilder(
      column: $table.lowestScore, builder: (column) => column);

  GeneratedColumn<double> get avgScore =>
      $composableBuilder(column: $table.avgScore, builder: (column) => column);

  $$QuizTableAnnotationComposer get quizId {
    final $$QuizTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableAnnotationComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StatisticTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StatisticTable,
    StatisticData,
    $$StatisticTableFilterComposer,
    $$StatisticTableOrderingComposer,
    $$StatisticTableAnnotationComposer,
    $$StatisticTableCreateCompanionBuilder,
    $$StatisticTableUpdateCompanionBuilder,
    (StatisticData, $$StatisticTableReferences),
    StatisticData,
    PrefetchHooks Function({bool quizId})> {
  $$StatisticTableTableManager(_$AppDatabase db, $StatisticTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatisticTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatisticTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatisticTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> quizId = const Value.absent(),
            Value<int> playCount = const Value.absent(),
            Value<int> highestScore = const Value.absent(),
            Value<int> lowestScore = const Value.absent(),
            Value<double> avgScore = const Value.absent(),
          }) =>
              StatisticCompanion(
            id: id,
            quizId: quizId,
            playCount: playCount,
            highestScore: highestScore,
            lowestScore: lowestScore,
            avgScore: avgScore,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int quizId,
            required int playCount,
            required int highestScore,
            required int lowestScore,
            required double avgScore,
          }) =>
              StatisticCompanion.insert(
            id: id,
            quizId: quizId,
            playCount: playCount,
            highestScore: highestScore,
            lowestScore: lowestScore,
            avgScore: avgScore,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StatisticTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({quizId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (quizId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.quizId,
                    referencedTable:
                        $$StatisticTableReferences._quizIdTable(db),
                    referencedColumn:
                        $$StatisticTableReferences._quizIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StatisticTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StatisticTable,
    StatisticData,
    $$StatisticTableFilterComposer,
    $$StatisticTableOrderingComposer,
    $$StatisticTableAnnotationComposer,
    $$StatisticTableCreateCompanionBuilder,
    $$StatisticTableUpdateCompanionBuilder,
    (StatisticData, $$StatisticTableReferences),
    StatisticData,
    PrefetchHooks Function({bool quizId})>;
typedef $$CompletedQuizTableCreateCompanionBuilder = CompletedQuizCompanion
    Function({
  Value<int> id,
  required int quizId,
  required int questionCount,
  required int rightQuestions,
  Value<DateTime> playedAt,
});
typedef $$CompletedQuizTableUpdateCompanionBuilder = CompletedQuizCompanion
    Function({
  Value<int> id,
  Value<int> quizId,
  Value<int> questionCount,
  Value<int> rightQuestions,
  Value<DateTime> playedAt,
});

final class $$CompletedQuizTableReferences extends BaseReferences<_$AppDatabase,
    $CompletedQuizTable, CompletedQuizData> {
  $$CompletedQuizTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuizTable _quizIdTable(_$AppDatabase db) => db.quiz
      .createAlias($_aliasNameGenerator(db.completedQuiz.quizId, db.quiz.id));

  $$QuizTableProcessedTableManager get quizId {
    final manager = $$QuizTableTableManager($_db, $_db.quiz)
        .filter((f) => f.id($_item.quizId!));
    final item = $_typedResult.readTableOrNull(_quizIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CompletedQuizTableFilterComposer
    extends Composer<_$AppDatabase, $CompletedQuizTable> {
  $$CompletedQuizTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get questionCount => $composableBuilder(
      column: $table.questionCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rightQuestions => $composableBuilder(
      column: $table.rightQuestions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnFilters(column));

  $$QuizTableFilterComposer get quizId {
    final $$QuizTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableFilterComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CompletedQuizTableOrderingComposer
    extends Composer<_$AppDatabase, $CompletedQuizTable> {
  $$CompletedQuizTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get questionCount => $composableBuilder(
      column: $table.questionCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rightQuestions => $composableBuilder(
      column: $table.rightQuestions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnOrderings(column));

  $$QuizTableOrderingComposer get quizId {
    final $$QuizTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableOrderingComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CompletedQuizTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompletedQuizTable> {
  $$CompletedQuizTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get questionCount => $composableBuilder(
      column: $table.questionCount, builder: (column) => column);

  GeneratedColumn<int> get rightQuestions => $composableBuilder(
      column: $table.rightQuestions, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  $$QuizTableAnnotationComposer get quizId {
    final $$QuizTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $db.quiz,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuizTableAnnotationComposer(
              $db: $db,
              $table: $db.quiz,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CompletedQuizTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CompletedQuizTable,
    CompletedQuizData,
    $$CompletedQuizTableFilterComposer,
    $$CompletedQuizTableOrderingComposer,
    $$CompletedQuizTableAnnotationComposer,
    $$CompletedQuizTableCreateCompanionBuilder,
    $$CompletedQuizTableUpdateCompanionBuilder,
    (CompletedQuizData, $$CompletedQuizTableReferences),
    CompletedQuizData,
    PrefetchHooks Function({bool quizId})> {
  $$CompletedQuizTableTableManager(_$AppDatabase db, $CompletedQuizTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletedQuizTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletedQuizTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletedQuizTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> quizId = const Value.absent(),
            Value<int> questionCount = const Value.absent(),
            Value<int> rightQuestions = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
          }) =>
              CompletedQuizCompanion(
            id: id,
            quizId: quizId,
            questionCount: questionCount,
            rightQuestions: rightQuestions,
            playedAt: playedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int quizId,
            required int questionCount,
            required int rightQuestions,
            Value<DateTime> playedAt = const Value.absent(),
          }) =>
              CompletedQuizCompanion.insert(
            id: id,
            quizId: quizId,
            questionCount: questionCount,
            rightQuestions: rightQuestions,
            playedAt: playedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CompletedQuizTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({quizId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (quizId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.quizId,
                    referencedTable:
                        $$CompletedQuizTableReferences._quizIdTable(db),
                    referencedColumn:
                        $$CompletedQuizTableReferences._quizIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CompletedQuizTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CompletedQuizTable,
    CompletedQuizData,
    $$CompletedQuizTableFilterComposer,
    $$CompletedQuizTableOrderingComposer,
    $$CompletedQuizTableAnnotationComposer,
    $$CompletedQuizTableCreateCompanionBuilder,
    $$CompletedQuizTableUpdateCompanionBuilder,
    (CompletedQuizData, $$CompletedQuizTableReferences),
    CompletedQuizData,
    PrefetchHooks Function({bool quizId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuizTableTableManager get quiz => $$QuizTableTableManager(_db, _db.quiz);
  $$QuestionTableTableManager get question =>
      $$QuestionTableTableManager(_db, _db.question);
  $$StatisticTableTableManager get statistic =>
      $$StatisticTableTableManager(_db, _db.statistic);
  $$CompletedQuizTableTableManager get completedQuiz =>
      $$CompletedQuizTableTableManager(_db, _db.completedQuiz);
}
