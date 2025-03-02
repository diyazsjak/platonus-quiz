part of 'attempt_questions_bloc.dart';

sealed class AttemptQuestionsEvent {}

final class AttemptQuestionsStarted extends AttemptQuestionsEvent {
  AttemptQuestionsStarted(this.questionsId);

  final int questionsId;
}
