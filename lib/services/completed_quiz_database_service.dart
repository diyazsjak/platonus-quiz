import '../core/database.dart';
import '../core/database_singleton.dart';

class CompletedQuizDatabaseService {
  final _database = DatabaseSingleton().database;

  Future<List<CompletedQuizData>> getAll(int quizId) async {
    return await _database.managers.completedQuiz
        .filter((f) => f.quizId.id(quizId))
        .get();
  }

  Future<int> insert(int quizId, int questionCount, int rightQuestions) async {
    return await _database.into(_database.completedQuiz).insert(
          CompletedQuizCompanion.insert(
            quizId: quizId,
            questionCount: questionCount,
            rightQuestions: rightQuestions,
          ),
        );
  }
}
