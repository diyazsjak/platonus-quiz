import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../services/question_database_service.dart';
import '../../services/quiz_database_service.dart';
import '../../models/question_model.dart';
import '../../models/quiz_model.dart';
import '../../services/settings_service.dart';
import '../../services/statistic_database_service.dart';

part 'ongoing_quiz_event.dart';
part 'ongoing_quiz_state.dart';

class OngoingQuizBloc extends Bloc<OngoingQuizEvent, OngoingQuizState> {
  final _settingsService = SettingsService();
  final quizManager = QuizDatabaseService();
  final questionManager = QuestionDatabaseService();
  final statisticDatabaseService = StatisticDatabaseService();

  late QuizModel? currentQuiz;
  late int? currentQuizId;
  int _currentlyAnsweredQuestions = 0;

  OngoingQuizBloc() : super(OngoingQuizInitial()) {
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
          map(OngoingQuizLoadSuccess(quiz: quizModel));
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
          map(OngoingQuizLoadSuccess(quiz: quizModel));
        } catch (e) {
          map(OngoingQuizLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<OngoingQuizQuestionAnswered>(
      (event, map) async {
        _currentlyAnsweredQuestions++;
        event.question.isQuestionAnswered = true;

        if (_currentlyAnsweredQuestions == currentQuiz!.questions.length) {
          map(OngoingQuizUpdateStatInProgress());
          final quizLength = currentQuiz!.questions.length;
          final rightQuestionsCount = currentQuiz!.getRightAnsweredQuestions();
          final score = ((rightQuestionsCount * 100) / quizLength).round();

          await statisticDatabaseService.update(
            currentQuizId!,
            score,
            quizLength,
            rightQuestionsCount,
          );

          map(OngoingQuizComplete(
            quizId: currentQuizId!,
            rightQuestionsCount: rightQuestionsCount,
          ));
          _currentlyAnsweredQuestions = 0;
        }
      },
    );

    on<OngoingQuizVariantSelected>(
      (event, map) => event.question.selectedVariant = event.variantPos,
    );
  }
}
