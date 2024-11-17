import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Quiz extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Question extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quizId => integer().references(Quiz, #id)();
  TextColumn get question => text()();
  TextColumn get variants => text()();
}

@DriftDatabase(tables: [Quiz, Question])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'database');
  }
}
