import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/failure.dart';
import '../core/file_parser.dart';
import '../models/question_model.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<QuizSelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          final quiz = await FileParser.parseFileToQuiz(event.filePath);
          map(QuizLoadSuccess(questions: quiz));
        } catch (e) {
          map(QuizLoadFailure(failure: WrongQuizFormatFailure()));
        }
      },
    );
  }
}
