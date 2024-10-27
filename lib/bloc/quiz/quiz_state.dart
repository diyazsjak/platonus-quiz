part of 'quiz_bloc.dart';

sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoadInProgress extends QuizState {}

final class QuizLoadSuccess extends QuizState {
  final QuizModel quiz;

  QuizLoadSuccess({required this.quiz});
}

final class QuizLoadFailure extends QuizState {
  final Failure failure;

  QuizLoadFailure({required this.failure});
}

final class QuizCompleteSuccess extends QuizState {
  final int rightQuestionsCount;

  QuizCompleteSuccess({required this.rightQuestionsCount});
}
