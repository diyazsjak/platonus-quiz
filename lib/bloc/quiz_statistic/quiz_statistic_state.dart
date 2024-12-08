part of 'quiz_statistic_bloc.dart';

sealed class QuizStatisticState {}

final class QuizStatisticInitial extends QuizStatisticState {}

final class QuizStatisticLoadInProgress extends QuizStatisticState {}

final class QuizStatisticLoadSuccess extends QuizStatisticState {
  final QuizStatisticModel? statistic;

  QuizStatisticLoadSuccess(this.statistic);
}

final class QuizStatisticLoadFailure extends QuizStatisticState {}
