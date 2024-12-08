part of 'quiz_statistic_bloc.dart';

sealed class QuizStatisticEvent {}

final class QuizStatisticLoadPressed extends QuizStatisticEvent {
  final int quizId;

  QuizStatisticLoadPressed(this.quizId);
}
