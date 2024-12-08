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

  Future<int> update(int quizId, int score) async {
    final StatisticData? statistic = await get(quizId);

    if (statistic == null) {
      await _database.into(_database.statistic).insert(
            StatisticCompanion.insert(
              quizId: quizId,
              playCount: 1,
              highestScore: score,
              lowestScore: score,
              avgScore: score.toDouble(),
            ),
          );
      return 1;
    }

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

    return await (_database.update(_database.statistic)
          ..where((f) => f.quizId.equals(quizId)))
        .write(statisticCompanion);
  }
}
