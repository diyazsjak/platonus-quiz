part of 'ongoing_quiz_bloc.dart';

sealed class QuizEvent {}

final class QuizFileSelected extends QuizEvent {
  final String filePath;

  QuizFileSelected({required this.filePath});
}

final class QuizLocalSelected extends QuizEvent {
  final int quizId;

  QuizLocalSelected({required this.quizId});
}

final class QuizQuestionAnswered extends QuizEvent {
  final QuestionModel question;

  QuizQuestionAnswered(this.question);
}

final class QuizVariantSelected extends QuizEvent {
  final QuestionModel question;
  final int variantPos;

  QuizVariantSelected(this.question, this.variantPos);
}
