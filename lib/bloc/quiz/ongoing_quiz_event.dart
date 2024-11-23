part of 'ongoing_quiz_bloc.dart';

sealed class OngoingQuizEvent {}

final class OngoingQuizFileSelected extends OngoingQuizEvent {
  final String filePath;

  OngoingQuizFileSelected({required this.filePath});
}

final class OngoingQuizLocalSelected extends OngoingQuizEvent {
  final int quizId;

  OngoingQuizLocalSelected({required this.quizId});
}

final class OngoingQuizQuestionAnswered extends OngoingQuizEvent {
  final QuestionModel question;

  OngoingQuizQuestionAnswered(this.question);
}

final class OngoingQuizVariantSelected extends OngoingQuizEvent {
  final QuestionModel question;
  final int variantPos;

  OngoingQuizVariantSelected(this.question, this.variantPos);
}
