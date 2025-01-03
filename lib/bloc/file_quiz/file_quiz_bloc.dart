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
          map(FileQuizLoadInProgress());
          await quizParserService.saveQuiz(event.filePath);
          map(FileQuizLoadSuccess());
        } on Exception catch (e) {
          if (e is WrongFileFormatException) {
            map(FileQuizLoadFailure(WrongFileFormatFailure()));
          } else if (e is WrongQuizFormatException) {
            map(FileQuizLoadFailure(WrongQuizFormatFailure()));
          } else if (e is QuizAlreadyExistsException) {
            map(FileQuizLoadFailure(QuizAlreadyExistsFailure()));
          } else {
            map(FileQuizLoadFailure(UnknownDatabaseFailure()));
          }
        }
      },
    );
  }
}
