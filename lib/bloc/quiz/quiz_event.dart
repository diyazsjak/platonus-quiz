part of 'quiz_bloc.dart';

sealed class QuizEvent {}

final class QuizSelected extends QuizEvent {
  final String filePath;

  QuizSelected({required this.filePath});
}

final class QuizQuestionAnswered extends QuizEvent {
  final QuestionModel question;

  QuizQuestionAnswered(this.question);
}
