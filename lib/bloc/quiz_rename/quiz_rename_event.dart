part of 'quiz_rename_bloc.dart';

sealed class QuizRenameEvent {}

final class QuizRenamePressed extends QuizRenameEvent {
  final int quizId;
  final String name;

  QuizRenamePressed({required this.quizId, required this.name});
}
