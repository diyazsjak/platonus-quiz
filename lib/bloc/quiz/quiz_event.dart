part of 'quiz_bloc.dart';

sealed class QuizEvent {}

final class QuizSelected extends QuizEvent {
  final String filePath;

  QuizSelected({required this.filePath});
}
