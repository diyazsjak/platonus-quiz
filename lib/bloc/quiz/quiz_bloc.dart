import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../core/file_parser.dart';
import '../../models/quiz_model.dart';
import '../../services/settings_service.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _settingsService = SettingsService();

  QuizBloc() : super(QuizInitial()) {
    on<QuizSelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          final quiz = await FileParser.parseFileToQuiz(event.filePath);

          final questionLimit = _settingsService.questionLimit.toInt();
          final shuffledQuestions = quiz.questions..shuffle();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          map(
            QuizLoadSuccess(
              quiz: QuizModel(
                quizName: quiz.quizName,
                questions: questions.toList(),
              ),
            ),
          );
        } catch (e) {
          map(QuizLoadFailure(failure: WrongQuizFormatFailure()));
        }
      },
    );
  }
}
