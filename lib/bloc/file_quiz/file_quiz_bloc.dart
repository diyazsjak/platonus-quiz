import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions.dart';
import '../../core/failure.dart';
import '../../services/quiz_parser_service.dart';

part 'file_quiz_event.dart';
part 'file_quiz_state.dart';

class FileQuizBloc extends Bloc<FileQuizEvent, FileQuizState> {
  final quizParserService = QuizParserService();

  FileQuizBloc() : super(FileQuizInitial()) {
    on<FileQuizSelected>(
      (event, map) async {
        try {
          map(FileQuizSaveInProgress());
          await quizParserService.saveQuiz(event.filePath);
          map(FileQuizSaveSuccess());
        } on Exception catch (e) {
          if (e is WrongFileFormatException) {
            map(FileQuizSaveFailure(WrongFileFormatFailure()));
          } else if (e is WrongQuizFormatException) {
            map(FileQuizSaveFailure(WrongQuizFormatFailure()));
          } else if (e is QuizAlreadyExistsException) {
            map(FileQuizSaveFailure(QuizAlreadyExistsFailure()));
          } else {
            map(FileQuizSaveFailure(UnknownDatabaseFailure()));
          }
        }
      },
    );
  }
}
