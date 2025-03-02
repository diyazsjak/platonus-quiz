part of 'attempt_questions_bloc.dart';

sealed class AttemptQuestionsState {}

final class AttemptQuestionsInitial extends AttemptQuestionsState {}

final class AttemptQuestionsLoadInProgress extends AttemptQuestionsState {}

final class AttemptQuestionsLoadSuccess extends AttemptQuestionsState {
  AttemptQuestionsLoadSuccess({required this.questions});

  final List<QuestionModel> questions;
}

final class AttemptQuestionsLoadFailure extends AttemptQuestionsState {}
