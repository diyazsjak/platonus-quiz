import '../core/database.dart';

class AttemptModel {
  final int id;
  final int quizId;
  final int questionsId;
  final int questionCount;
  final int rightQuestionCount;
  final DateTime playedAt;

  AttemptModel({
    required this.id,
    required this.quizId,
    required this.questionsId,
    required this.questionCount,
    required this.rightQuestionCount,
    required this.playedAt,
  });

  factory AttemptModel.fromDatabase(AttemptData attempt) {
    return AttemptModel(
      id: attempt.id,
      quizId: attempt.quizId,
      questionsId: attempt.questionsId,
      questionCount: attempt.questionCount,
      rightQuestionCount: attempt.rightQuestions,
      playedAt: attempt.playedAt,
    );
  }
}
