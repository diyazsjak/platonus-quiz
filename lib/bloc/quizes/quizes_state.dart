part of 'quizes_bloc.dart';

sealed class QuizesState {}

final class QuizesInitial extends QuizesState {}

final class QuizesLoadInProgress extends QuizesState {}

final class QuizesLoadSuccess extends QuizesState {
  final List<QuizCardModel> quizes;

  QuizesLoadSuccess(this.quizes);
}

final class QuizesLoadFailure extends QuizesState {
  final Failure failure;

  QuizesLoadFailure({required this.failure});
}
