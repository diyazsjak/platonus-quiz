part of 'ongoing_quiz_bloc.dart';

sealed class OngoingQuizState {}

final class OngoingQuizInitial extends OngoingQuizState {}

final class OngoingQuizLoadInProgress extends OngoingQuizState {
  final bool isRestarted;

  OngoingQuizLoadInProgress({this.isRestarted = false});
}

final class OngoingQuizLoadSuccess extends OngoingQuizState {
  final QuizModel quiz;

  OngoingQuizLoadSuccess({required this.quiz});
}

final class OngoingQuizLoadFailure extends OngoingQuizState {
  final Failure failure;

  OngoingQuizLoadFailure({required this.failure});
}

final class OngoingQuizUpdateStatInProgress extends OngoingQuizState {}

final class OngoingQuizComplete extends OngoingQuizState {
  final int quizId;
  final int rightQuestionsCount;

  OngoingQuizComplete({
    required this.quizId,
    required this.rightQuestionsCount,
  });
}
