import 'database.dart';

class QuestionManager {
  final _database = AppDatabase();

  Future<List<QuestionData>> getAll(int quizId) async {
    return await _database.managers.question
        .filter((f) => f.quizId.id(quizId))
        .get();
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
