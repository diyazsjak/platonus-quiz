import 'package:drift/drift.dart';

import 'database.dart';
import 'database_singleton.dart';

class QuizManager {
  final _database = DatabaseSingleton().database;

  Future<bool> isExists(String quizName) async {
    final quiz = await _database.managers.quiz
        .filter((f) => f.name.equals(quizName))
        .getSingleOrNull();

    return quiz != null;
  }

  Future updateQuestionAmount(int id, int length) async {
    await (_database.update(_database.quiz)
          ..where(
            (f) => f.id.equals(id),
          ))
        .write(QuizCompanion(length: Value(length)));
  }

  Future<List<QuizData>> getAll() async {
    return await _database.managers.quiz.get();
  }

  Future<QuizData> getSingle(int id) async {
    return await _database.managers.quiz.filter((f) => f.id(id)).getSingle();
  }

  Future<int> insert(String quizName) async {
    return await _database.into(_database.quiz).insert(
          QuizCompanion.insert(name: quizName),
        );
  }
}
