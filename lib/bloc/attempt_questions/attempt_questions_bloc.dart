import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/question_model.dart';
import '../../services/question_database_service.dart';
import '../../services/quiz_parser_service.dart';

part 'attempt_questions_event.dart';
part 'attempt_questions_state.dart';

class AttemptQuestionsBloc
    extends Bloc<AttemptQuestionsEvent, AttemptQuestionsState> {
  final _questionService = QuestionDatabaseService();

  AttemptQuestionsBloc() : super(AttemptQuestionsInitial()) {
    on<AttemptQuestionsStarted>(
      (event, emit) async {
        try {
          emit(AttemptQuestionsLoadInProgress());
          final attemptQuestions =
              await _questionService.getAttemptQuestions(event.questionsId);
          final questionsJson =
              jsonDecode(attemptQuestions.questions) as List<dynamic>;

          final questions = await Future.wait([
            for (final question in questionsJson)
              _getQuestion(question['id'], question['selectedVariant'])
          ]);

          emit(AttemptQuestionsLoadSuccess(questions: questions));
        } catch (e) {
          emit(AttemptQuestionsLoadFailure());
        }
      },
    );
  }

  Future<QuestionModel> _getQuestion(
    int questionId,
    int selectedVariant,
  ) async {
    final question = await _questionService.getQuestion(questionId);

    return QuestionModel(
      id: question.id,
      question: question.question,
      variants: QuizParserService.getVariantsMapFromString(question.variants),
      selectedVariant: selectedVariant,
    );
  }
}
