import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../database/question_manager.dart';
import '../../database/quiz_manager.dart';
import '../../services/quiz_parser_service.dart';
import '../../models/question_model.dart';
import '../../models/quiz_model.dart';
import '../../services/settings_service.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _settingsService = SettingsService();
  late QuizModel? currentQuiz;
  int _currentlyAnsweredQuestions = 0;

  QuizBloc() : super(QuizInitial()) {
    on<QuizFileSelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          final wholeQuiz =
              await QuizParserService.parseFileToQuiz(event.filePath);

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

    on<QuizLocalSelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          final quizManagar = QuizManager();
          final questionManager = QuestionManager();
          final quiz = await quizManagar.getSingle(event.quizId);
          final shuffledQuestions = await questionManager.getAll(event.quizId)
            ..shuffle();

          final questionLimit = _settingsService.questionLimit.toInt();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quizModel = QuizModel.fromDatabase(quiz, questions.toList());

          currentQuiz = quizModel;
          map(QuizLoadSuccess(quiz: quizModel));
        } catch (e) {
          map(QuizLoadFailure(failure: WrongQuizFormatFailure()));
        }
      },
    );

    on<QuizQuestionAnswered>(
      (event, map) {
        _currentlyAnsweredQuestions++;
        event.question.isQuestionAnswered = true;

        if (_currentlyAnsweredQuestions == currentQuiz!.questions.length) {
          final rightQuestionsCount = currentQuiz!.getRightAnsweredQuestions();
          map(QuizCompleteSuccess(rightQuestionsCount: rightQuestionsCount));
          _currentlyAnsweredQuestions = 0;
        }
      },
    );

    on<QuizVariantSelected>(
      (event, map) => event.question.selectedVariant = event.variantPos,
    );
  }
}
