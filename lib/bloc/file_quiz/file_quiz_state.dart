part of 'file_quiz_bloc.dart';

sealed class FileQuizState {}

final class FileQuizInitial extends FileQuizState {}

final class FileQuizLoadInProgress extends FileQuizState {}

final class FileQuizLoadSuccess extends FileQuizState {}

final class FileQuizLoadFailure extends FileQuizState {
  final Failure failure;

  FileQuizLoadFailure(this.failure);
}
