import '../database/database.dart';
import '../database/database_singleton.dart';

class QuestionDatabaseService {
  final _database = DatabaseSingleton().database;

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
