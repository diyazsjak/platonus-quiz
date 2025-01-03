part of 'quiz_bloc.dart';

sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoadInProgress extends QuizState {
  final bool isRestarted;

  QuizLoadInProgress({this.isRestarted = false});
}

final class QuizLoadSuccess extends QuizState {
  final QuizModel quiz;

  QuizLoadSuccess({required this.quiz});
}

final class QuizLoadFailure extends QuizState {
  final Failure failure;

  QuizLoadFailure({required this.failure});
}

final class QuizUpdateStatInProgress extends QuizState {}

final class QuizComplete extends QuizState {
  final int quizId;
  final int rightQuestionsCount;

  QuizComplete({
    required this.quizId,
    required this.rightQuestionsCount,
  });
}
