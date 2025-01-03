part of 'file_quiz_bloc.dart';

sealed class FileQuizState {}

final class FileQuizInitial extends FileQuizState {}

final class FileQuizSaveInProgress extends FileQuizState {}

final class FileQuizSaveSuccess extends FileQuizState {}

final class FileQuizSaveFailure extends FileQuizState {
  final Failure failure;

  FileQuizSaveFailure(this.failure);
}
