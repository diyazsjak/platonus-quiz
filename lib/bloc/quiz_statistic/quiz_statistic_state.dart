part of 'quiz_statistic_bloc.dart';

sealed class QuizStatisticState {}

final class QuizStatisticInitial extends QuizStatisticState {}

final class QuizStatisticLoadInProgress extends QuizStatisticState {}

final class QuizStatisticLoadSuccess extends QuizStatisticState {
  final QuizStatisticModel? statistic;

  QuizStatisticLoadSuccess(this.statistic);
}

final class QuizStatisticLoadFailure extends QuizStatisticState {}

final class QuizStatisticClearInProgress extends QuizStatisticState {
  final int quizId;

  QuizStatisticClearInProgress(this.quizId);
}

final class QuizStatisticClearSuccess extends QuizStatisticState {}

final class QuizStatisticClearFailure extends QuizStatisticState {}
