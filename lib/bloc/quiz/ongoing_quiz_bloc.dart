import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../services/question_database_service.dart';
import '../../services/quiz_database_service.dart';
import '../../services/quiz_parser_service.dart';
import '../../models/question_model.dart';
import '../../models/quiz_model.dart';
import '../../services/settings_service.dart';

part 'ongoing_quiz_event.dart';
part 'ongoing_quiz_state.dart';

class OngoingQuizBloc extends Bloc<OngoingQuizEvent, OngoingQuizState> {
  final _settingsService = SettingsService();
  final quizManager = QuizDatabaseService();
  final questionManager = QuestionDatabaseService();

  late QuizModel? currentQuiz;
  late int? currentQuizId;
  int _currentlyAnsweredQuestions = 0;

  OngoingQuizBloc() : super(OngoingQuizInitial()) {
    on<OngoingQuizFileSelected>(
      (event, map) async {
        try {
          map(OngoingQuizLoadInProgress());
          await Future.delayed(const Duration(milliseconds: 200));
          final wholeQuiz =
              await QuizParserService.parseFileToQuiz(event.filePath);

          final questionLimit = _settingsService.questionLimit.toInt();
          final shuffledQuestions = wholeQuiz.questions..shuffle();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quiz = QuizModel(
            quizName: wholeQuiz.quizName,
            questions: questions.toList(),
          );

          final savedQuizId = await quizManager.getIdByName(wholeQuiz.quizName);

          currentQuiz = quiz;
          currentQuizId = savedQuizId!;
          _currentlyAnsweredQuestions = 0;
          map(OngoingQuizLoadSuccess(quiz: quiz, isQuizSaved: true));
        } catch (e) {
          map(OngoingQuizLoadFailure(failure: WrongQuizFormatFailure()));
        }
      },
    );

    on<OngoingQuizLocalSelected>(
      (event, map) async {
        try {
          map(OngoingQuizLoadInProgress());
          final quiz = await quizManager.getSingle(event.quizId);
          final shuffledQuestions = await questionManager.getAll(event.quizId)
            ..shuffle();

          final questionLimit = _settingsService.questionLimit.toInt();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quizModel = QuizModel.fromDatabase(quiz, questions.toList());

          currentQuiz = quizModel;
          currentQuizId = event.quizId;
          _currentlyAnsweredQuestions = 0;
          map(OngoingQuizLoadSuccess(quiz: quizModel, isQuizSaved: false));
        } catch (e) {
          map(OngoingQuizLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<OngoingQuizRestarted>(
      (event, map) async {
        try {
          map(OngoingQuizLoadInProgress(isRestarted: true));
          final quiz = await quizManager.getSingle(currentQuizId!);
          final shuffledQuestions = await questionManager.getAll(currentQuizId!)
            ..shuffle();

          final questionLimit = _settingsService.questionLimit.toInt();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quizModel = QuizModel.fromDatabase(quiz, questions.toList());

          currentQuiz = quizModel;
          _currentlyAnsweredQuestions = 0;
          map(OngoingQuizLoadSuccess(quiz: quizModel, isQuizSaved: false));
        } catch (e) {
          map(OngoingQuizLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<OngoingQuizQuestionAnswered>(
      (event, map) {
        _currentlyAnsweredQuestions++;
        event.question.isQuestionAnswered = true;

        if (_currentlyAnsweredQuestions == currentQuiz!.questions.length) {
          final rightQuestionsCount = currentQuiz!.getRightAnsweredQuestions();
          map(OngoingQuizComplete(rightQuestionsCount: rightQuestionsCount));
          _currentlyAnsweredQuestions = 0;
        }
      },
    );

    on<OngoingQuizVariantSelected>(
      (event, map) => event.question.selectedVariant = event.variantPos,
    );
  }
}
