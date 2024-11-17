part of 'quizes_bloc.dart';

sealed class QuizesEvent {}

final class QuizesStarted extends QuizesEvent {}

final class QuizesQuizDeletePressed extends QuizesEvent {
  final int id;

  QuizesQuizDeletePressed(this.id);
}
