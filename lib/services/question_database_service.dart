import '../core/database.dart';
import '../core/database_singleton.dart';

class QuestionDatabaseService {
  final _database = DatabaseSingleton().database;

  Future<List<QuestionData>> getAll(int quizId) async {
    return await _database.managers.question
        .filter((f) => f.quizId.id(quizId))
        .get();
  }

  Future<List<QuestionData>> getQuestions(List<int> questionIds) async {
    final questions = <QuestionData>[];

    for (final questionId in questionIds) {
      final question = await _database.managers.question
          .filter((f) => f.id(questionId))
          .getSingle();
      questions.add(question);
    }

    return questions;
  }

  Future<AttemptQuestion> getAttemptQuestions(int attemptQuestionsId) async {
    return await _database.managers.attemptQuestions
        .filter((f) => f.id(attemptQuestionsId))
        .getSingle();
  }

  Future<int> insert({
    required int quizId,
    required String question,
    required String variants,
  }) async {
    return await _database.into(_database.question).insert(
          QuestionCompanion.insert(
            quizId: quizId,
            question: question,
            variants: variants,
          ),
        );
  }
}
