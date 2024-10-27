import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../core/file_parser.dart';
import '../../models/quiz_model.dart';
import '../../services/settings_service.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _settingsService = SettingsService();
  late QuizModel? currentQuiz;
  int _currentlyAnsweredQuestions = 0;

  QuizBloc() : super(QuizInitial()) {
    on<QuizSelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          final wholeQuiz = await FileParser.parseFileToQuiz(event.filePath);

          final questionLimit = _settingsService.questionLimit.toInt();
          final shuffledQuestions = wholeQuiz.questions..shuffle();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quiz = QuizModel(
            quizName: wholeQuiz.quizName,
            questions: questions.toList(),
          );

          currentQuiz = quiz;
          map(QuizLoadSuccess(quiz: quiz));
        } catch (e) {
          map(QuizLoadFailure(failure: WrongQuizFormatFailure()));
        }
      },
    );

    on<QuizQuestionAnswered>(
      (event, map) {
        _currentlyAnsweredQuestions++;
        if (_currentlyAnsweredQuestions == currentQuiz!.questions.length) {
          final rightQuestionsCount = currentQuiz!.getRightAnsweredQuestions();
          map(QuizCompleteSuccess(rightQuestionsCount: rightQuestionsCount));
          _currentlyAnsweredQuestions = 0;
        }
      },
    );
  }
}
