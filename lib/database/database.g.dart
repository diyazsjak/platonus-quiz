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
  @override
  List<GeneratedColumn> get $columns => [id, name];
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
  const QuizData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  QuizCompanion toCompanion(bool nullToAbsent) {
    return QuizCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory QuizData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  QuizData copyWith({int? id, String? name}) => QuizData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  QuizData copyWithCompanion(QuizCompanion data) {
    return QuizData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizData && other.id == this.id && other.name == this.name);
}

class QuizCompanion extends UpdateCompanion<QuizData> {
  final Value<int> id;
  final Value<String> name;
  const QuizCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  QuizCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<QuizData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  QuizCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return QuizCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
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
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES quiz (id)'));
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuizTable quiz = $QuizTable(this);
  late final $QuestionTable question = $QuestionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [quiz, question];
}

typedef $$QuizTableCreateCompanionBuilder = QuizCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$QuizTableUpdateCompanionBuilder = QuizCompanion Function({
  Value<int> id,
  Value<String> name,
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
    PrefetchHooks Function({bool questionRefs})> {
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
          }) =>
              QuizCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              QuizCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$QuizTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({questionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (questionRefs) db.question],
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
    PrefetchHooks Function({bool questionRefs})>;
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

  $$QuizTableProcessedTableManager? get quizId {
    if ($_item.quizId == null) return null;
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuizTableTableManager get quiz => $$QuizTableTableManager(_db, _db.quiz);
  $$QuestionTableTableManager get question =>
      $$QuestionTableTableManager(_db, _db.question);
}
