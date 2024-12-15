import 'dart:math';

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

  factory QuizStatisticModel.fake() {
    return QuizStatisticModel(
      playCount: 10,
      highestScore: 80,
      lowestScore: 80,
      avgScore: 80,
      quizes: List.generate(
        8,
        (index) => CompletedQuizModel(
          questionCount: 30,
          rightQuestionCount: Random().nextInt(20) + 10,
          playedAt: DateTime.now(),
        ),
      ),
    );
  }
}
