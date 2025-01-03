part of 'ongoing_quiz_bloc.dart';

sealed class OngoingQuizEvent {}

final class OngoingQuizSelected extends OngoingQuizEvent {
  final int quizId;

  OngoingQuizSelected({required this.quizId});
}

final class OngoingQuizRestarted extends OngoingQuizEvent {}

final class OngoingQuizQuestionAnswered extends OngoingQuizEvent {
  final QuestionModel question;

  OngoingQuizQuestionAnswered(this.question);
}

final class OngoingQuizVariantSelected extends OngoingQuizEvent {
  final QuestionModel question;
  final int variantPos;

  OngoingQuizVariantSelected(this.question, this.variantPos);
}
