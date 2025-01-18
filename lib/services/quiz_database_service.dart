import 'package:drift/drift.dart';

import '../core/database.dart';
import '../core/database_singleton.dart';

class QuizDatabaseService {
  final _database = DatabaseSingleton().database;

  Future<void> rename(int id, String name) async {
    await (_database.update(_database.quiz)
          ..where(
            (f) => f.id.equals(id),
          ))
        .write(QuizCompanion(name: Value(name)));
  }

  Future<int?> getIdByName(String quizName) async {
    final quiz = await _database.managers.quiz
        .filter((f) => f.name.equals(quizName))
        .getSingleOrNull();

    return quiz?.id;
  }

  Future<bool> isExists(String quizName) async {
    final quiz = await _database.managers.quiz
        .filter((f) => f.name.equals(quizName))
        .getSingleOrNull();

    return quiz != null;
  }

  Future<List<QuizData>> getAll() async {
    return await _database.managers.quiz.get();
  }

  Future<QuizData> getSingle(int id) async {
    return await _database.managers.quiz.filter((f) => f.id(id)).getSingle();
  }

  Future<int> insert({
    required String quizName,
    required String fileContent,
    required int length,
  }) async {
    return await _database.into(_database.quiz).insert(
          QuizCompanion.insert(name: quizName, length: Value(length)),
        );
  }

  Future<void> delete(int id) async {
    await _database.transaction(() async {
      await _database.managers.quiz.filter((f) => f.id(id)).delete();
      await _database.managers.question.filter((f) => f.quizId.id(id)).delete();
      await _database.managers.statistic
          .filter((f) => f.quizId.id(id))
          .delete();
      await _database.managers.attempt.filter((f) => f.quizId.id(id)).delete();
      await _database.managers.attemptQuestions
          .filter((f) => f.quizId.id(id))
          .delete();
    });
  }
}
