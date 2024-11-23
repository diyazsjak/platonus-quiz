part of 'quizes_list_bloc.dart';

sealed class QuizesListState {}

final class QuizesListInitial extends QuizesListState {}

final class QuizesListLoadInProgress extends QuizesListState {}

final class QuizesListLoadSuccess extends QuizesListState {
  final List<QuizCardModel> quizes;

  QuizesListLoadSuccess(this.quizes);
}

final class QuizesListLoadFailure extends QuizesListState {
  final Failure failure;

  QuizesListLoadFailure({required this.failure});
}

final class QuizesListQuizDeleteSuccess extends QuizesListState {}

final class QuizesListQuizDeleteFailure extends QuizesListState {}
