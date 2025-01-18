part of 'quiz_rename_bloc.dart';

sealed class QuizRenameState {}

final class QuizRenameInitial extends QuizRenameState {}

final class QuizRenameInProgress extends QuizRenameState {}

final class QuizRenameFailure extends QuizRenameState {}

final class QuizRenameSuccess extends QuizRenameState {
  final String newName;

  QuizRenameSuccess({required this.newName});
}
