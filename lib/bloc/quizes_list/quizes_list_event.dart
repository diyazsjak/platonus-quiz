part of 'quizes_list_bloc.dart';

sealed class QuizesListEvent {}

final class QuizesListStarted extends QuizesListEvent {}

final class QuizesListQuizDeletePressed extends QuizesListEvent {
  final int id;

  QuizesListQuizDeletePressed(this.id);
}
