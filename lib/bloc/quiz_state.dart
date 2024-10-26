part of 'quiz_bloc.dart';

sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoadInProgress extends QuizState {}

final class QuizLoadSuccess extends QuizState {
  final List<QuestionModel> questions;

  QuizLoadSuccess({required this.questions});
}

final class QuizLoadFailure extends QuizState {
  final Failure failure;

  QuizLoadFailure({required this.failure});
}
