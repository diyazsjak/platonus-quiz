part of 'file_quiz_bloc.dart';

sealed class FileQuizEvent {}

final class FileQuizSelected extends FileQuizEvent {
  final String filePath;

  FileQuizSelected(this.filePath);
}
