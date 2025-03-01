part of 'quiz_bloc.dart';

sealed class QuizEvent {}

final class QuizSelected extends QuizEvent {
  final int quizId;

  QuizSelected({required this.quizId});
}

final class QuizAttemptRetrySelected extends QuizEvent {
  final AttemptModel attempt;
  final bool shuffle;

  QuizAttemptRetrySelected({required this.attempt, required this.shuffle});
}

final class QuizRestarted extends QuizEvent {}

final class QuizQuestionAnswered extends QuizEvent {
  final QuestionModel question;

  QuizQuestionAnswered(this.question);
}

final class QuizVariantSelected extends QuizEvent {
  final QuestionModel question;
  final int variantPos;

  QuizVariantSelected(this.question, this.variantPos);
}
