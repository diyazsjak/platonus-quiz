import 'package:drift/drift.dart';

import '../core/database.dart';
import '../core/database_singleton.dart';

class StatisticDatabaseService {
  final _database = DatabaseSingleton().database;

  Future<StatisticData?> get(int quizId) async {
    return await _database.managers.statistic
        .filter((f) => f.quizId.id(quizId))
        .getSingleOrNull();
  }

  Future<int> insert(int quizId, int score) async {
    final StatisticData? statistic = await get(quizId);
    final playCount = statistic?.playCount ?? 1;
    final highestScore = statistic?.highestScore ?? score;
    final lowestScore = statistic?.lowestScore ?? score;
    final avgScore = statistic?.avgScore ?? score;

    final updatedPlayCount = playCount + 1;
    final updatedHighestScore = (highestScore > score) ? highestScore : score;
    final updatedLowestScore = (lowestScore < score) ? lowestScore : score;
    final updatedAvgScore = ((avgScore * playCount) + score) / updatedPlayCount;

    final statisticCompanion = StatisticCompanion(
      playCount: Value(playCount + 1),
      highestScore: Value(updatedHighestScore),
      lowestScore: Value(updatedLowestScore),
      avgScore: Value(updatedAvgScore),
    );

    return await (_database.update(_database.statistic)
          ..where((f) => f.quizId.equals(quizId)))
        .write(statisticCompanion);
  }
}
