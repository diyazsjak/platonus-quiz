import 'package:drift/drift.dart';

import '../core/database.dart';
import '../core/database_singleton.dart';

class StatisticDatabaseService {
  final _database = DatabaseSingleton().database;

  Future<(StatisticData?, List<CompletedQuizData>)> get(int quizId) async {
    return await _database.transaction(() async {
      final statisticData = await _database.managers.statistic
          .filter((f) => f.quizId.id(quizId))
          .getSingleOrNull();
      final quizesData = await _database.managers.completedQuiz
          .filter((f) => f.quizId.id(quizId))
          .get();

      return (statisticData, quizesData);
    });
  }

  Future<void> update(
    int quizId,
    int score,
    int questionCount,
    int rightQuestions,
  ) async {
    return await _database.transaction(() async {
      await _insertCompletedQuiz(quizId, questionCount, rightQuestions);

      final statistic = await _database.managers.statistic
          .filter((f) => f.quizId.id(quizId))
          .getSingleOrNull();

      if (statistic != null) {
        await _updateStatistic(statistic, score, quizId);
        return;
      }

      await _database.into(_database.statistic).insert(
            StatisticCompanion.insert(
              quizId: quizId,
              playCount: 1,
              highestScore: score,
              lowestScore: score,
              avgScore: score.toDouble(),
            ),
          );
    });
  }

  Future<void> _updateStatistic(
    StatisticData statistic,
    int score,
    int quizId,
  ) async {
    final playCount = statistic.playCount;
    final highestScore = statistic.highestScore;
    final lowestScore = statistic.lowestScore;
    final avgScore = statistic.avgScore;

    final updatedPlayCount = playCount + 1;
    final updatedHighestScore = (highestScore > score) ? highestScore : score;
    final updatedLowestScore = (lowestScore < score) ? lowestScore : score;
    final updatedAvgScore = ((avgScore * playCount) + score) / updatedPlayCount;

    final statisticCompanion = StatisticCompanion(
      playCount: Value(updatedPlayCount),
      highestScore: Value(updatedHighestScore),
      lowestScore: Value(updatedLowestScore),
      avgScore: Value(updatedAvgScore),
    );

    await (_database.update(_database.statistic)
          ..where((f) => f.quizId.equals(quizId)))
        .write(statisticCompanion);
  }

  Future<int> _insertCompletedQuiz(
    int quizId,
    int questionCount,
    int rightQuestions,
  ) async {
    return await _database.into(_database.completedQuiz).insert(
          CompletedQuizCompanion.insert(
            quizId: quizId,
            questionCount: questionCount,
            rightQuestions: rightQuestions,
          ),
        );
  }
}
