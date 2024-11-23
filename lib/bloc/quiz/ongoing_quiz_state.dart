part of 'ongoing_quiz_bloc.dart';

sealed class OngoingQuizState {}

final class OngoingQuizInitial extends OngoingQuizState {}

final class OngoingQuizLoadInProgress extends OngoingQuizState {}

final class OngoingQuizLoadSuccess extends OngoingQuizState {
  final bool isQuizSaved;
  final QuizModel quiz;

  OngoingQuizLoadSuccess({required this.quiz, required this.isQuizSaved});
}

final class OngoingQuizLoadFailure extends OngoingQuizState {
  final Failure failure;

  OngoingQuizLoadFailure({required this.failure});
}

final class OngoingQuizComplete extends OngoingQuizState {
  final int rightQuestionsCount;

  OngoingQuizComplete({required this.rightQuestionsCount});
}
