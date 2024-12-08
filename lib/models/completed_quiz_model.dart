import '../core/database.dart';

class CompletedQuizModel {
  final int questionCount;
  final int rightQuestionCount;
  final DateTime playedAt;

  CompletedQuizModel({
    required this.questionCount,
    required this.rightQuestionCount,
    required this.playedAt,
  });

  factory CompletedQuizModel.fromDatabase(CompletedQuizData completedQuiz) {
    return CompletedQuizModel(
      questionCount: completedQuiz.questionCount,
      rightQuestionCount: completedQuiz.rightQuestions,
      playedAt: completedQuiz.playedAt,
    );
  }
}
