import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Quiz extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get length => integer().nullable()();
}

class Question extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quizId => integer().references(
        Quiz,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  TextColumn get question => text()();
  TextColumn get variants => text()();
}

class Statistic extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quizId => integer().references(
        Quiz,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  IntColumn get playCount => integer()();
  IntColumn get highestScore => integer()();
  IntColumn get lowestScore => integer()();
  RealColumn get avgScore => real()();
}

class Attempt extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get questionsId => integer().references(
        AttemptQuestions,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  IntColumn get quizId => integer().references(
        Quiz,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  IntColumn get questionCount => integer()();
  IntColumn get rightQuestions => integer()();
  DateTimeColumn get playedAt => dateTime().withDefault(currentDateAndTime)();
}

class AttemptQuestions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quizId => integer().references(
        Quiz,
        #id,
        onDelete: KeyAction.cascade,
        onUpdate: KeyAction.cascade,
      )();
  TextColumn get questions => text()();
}

@DriftDatabase(tables: [Quiz, Question, Statistic, Attempt, AttemptQuestions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'database');
  }
}
