import '../core/database.dart';
import 'completed_quiz_model.dart';

class QuizStatisticModel {
  final int playCount;
  final int highestScore;
  final int lowestScore;
  final double avgScore;
  final List<CompletedQuizModel> quizes;

  QuizStatisticModel({
    required this.playCount,
    required this.highestScore,
    required this.lowestScore,
    required this.avgScore,
    required this.quizes,
  });

  factory QuizStatisticModel.fromDatabase(
    StatisticData statistic,
    List<CompletedQuizData> completedQuizes,
  ) {
    return QuizStatisticModel(
      playCount: statistic.playCount,
      highestScore: statistic.highestScore,
      lowestScore: statistic.lowestScore,
      avgScore: statistic.avgScore,
      quizes: completedQuizes
          .map((quiz) => CompletedQuizModel.fromDatabase(quiz))
          .toList(),
    );
  }
}
