import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../models/attempt_model.dart';
import '../../services/question_database_service.dart';
import '../../services/quiz_database_service.dart';
import '../../models/question_model.dart';
import '../../models/quiz_model.dart';
import '../../services/settings_service.dart';
import '../../services/statistic_database_service.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final _settingsService = SettingsService();
  final _quizService = QuizDatabaseService();
  final _questionService = QuestionDatabaseService();
  final _statisticService = StatisticDatabaseService();

  late QuizModel? currentQuiz;
  late int? currentQuizId;
  bool _isAttemptQuiz = false;
  int _currentlyAnsweredQuestions = 0;

  QuizBloc() : super(QuizInitial()) {
    on<QuizSelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          _isAttemptQuiz = false;
          final quiz = await _quizService.getSingle(event.quizId);
          final shuffledQuestions = await _questionService.getAll(event.quizId)
            ..shuffle();

          final questionLimit = _settingsService.questionLimit.toInt();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quizModel = QuizModel.fromDatabase(quiz, questions.toList());

          currentQuiz = quizModel;
          currentQuizId = event.quizId;
          _currentlyAnsweredQuestions = 0;
          map(QuizLoadSuccess(quiz: quizModel));
        } catch (e) {
          map(QuizLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<QuizAttemptRetrySelected>(
      (event, map) async {
        try {
          map(QuizLoadInProgress());
          _isAttemptQuiz = true;
          final attemptQuestions = await _questionService
              .getAttemptQuestions(event.attempt.questionsId);

          final questionsJson =
              jsonDecode(attemptQuestions.questions) as List<dynamic>;

          final questions = await _questionService.getQuestions(
            questionsJson.map((question) => question['id'] as int).toList(),
          );
          if (event.shuffle) questions.shuffle();

          final quiz = await _quizService.getSingle(event.attempt.quizId);
          final quizModel = QuizModel.fromDatabase(
            quiz,
            questions.toList(),
          );

          currentQuiz = quizModel;
          currentQuizId = event.attempt.quizId;
          _currentlyAnsweredQuestions = 0;
          map(QuizLoadSuccess(quiz: quizModel));
        } catch (e) {
          map(QuizLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<QuizRestarted>(
      (event, map) async {
        try {
          map(QuizLoadInProgress(isRestarted: true));
          if (_isAttemptQuiz) {
            final questions = currentQuiz!.questions..shuffle();
            final quiz = QuizModel(
              questions: questions,
              quizName: currentQuiz!.quizName,
            );
            map(QuizLoadSuccess(quiz: quiz));
            return;
          }

          final quiz = await _quizService.getSingle(currentQuizId!);
          final shuffledQuestions =
              await _questionService.getAll(currentQuizId!)
                ..shuffle();

          final questionLimit = _settingsService.questionLimit.toInt();
          final questions = shuffledQuestions.getRange(0, questionLimit);

          final quizModel = QuizModel.fromDatabase(quiz, questions.toList());

          currentQuiz = quizModel;
          _currentlyAnsweredQuestions = 0;
          map(QuizLoadSuccess(quiz: quizModel));
        } catch (e) {
          map(QuizLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<QuizQuestionAnswered>(
      (event, map) async {
        _currentlyAnsweredQuestions++;
        event.question.isQuestionAnswered = true;

        if (_currentlyAnsweredQuestions == currentQuiz!.questions.length) {
          map(QuizUpdateStatInProgress());
          final quizLength = currentQuiz!.questions.length;
          final rightQuestionsCount = currentQuiz!.getRightAnsweredQuestions();
          final score = ((rightQuestionsCount * 100) / quizLength).round();

          await _statisticService.update(
            currentQuizId!,
            score,
            quizLength,
            rightQuestionsCount,
            currentQuiz!.questionsToJson(),
          );

          map(QuizComplete(
            quizId: currentQuizId!,
            rightQuestionsCount: rightQuestionsCount,
          ));
          _currentlyAnsweredQuestions = 0;
        }
      },
    );

    on<QuizVariantSelected>(
      (event, map) => event.question.selectedVariant = event.variantPos,
    );
  }
}
