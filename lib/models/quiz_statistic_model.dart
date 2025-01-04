import 'dart:math';

import '../core/database.dart';
import 'attempt_model.dart';

class QuizStatisticModel {
  final int playCount;
  final int highestScore;
  final int lowestScore;
  final double avgScore;
  final List<AttemptModel> quizes;

  QuizStatisticModel({
    required this.playCount,
    required this.highestScore,
    required this.lowestScore,
    required this.avgScore,
    required this.quizes,
  });

  factory QuizStatisticModel.fromDatabase(
    StatisticData statistic,
    List<AttemptData> attempts,
  ) {
    return QuizStatisticModel(
      playCount: statistic.playCount,
      highestScore: statistic.highestScore,
      lowestScore: statistic.lowestScore,
      avgScore: statistic.avgScore,
      quizes: attempts.map((quiz) => AttemptModel.fromDatabase(quiz)).toList(),
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
        (index) => AttemptModel(
          id: -1,
          quizId: -1,
          questionsId: -1,
          questionCount: 30,
          rightQuestionCount: Random().nextInt(20) + 10,
          playedAt: DateTime.now(),
        ),
      ),
    );
  }
}
