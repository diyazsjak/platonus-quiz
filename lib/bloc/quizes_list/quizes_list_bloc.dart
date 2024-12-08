import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../services/quiz_database_service.dart';
import '../../models/quiz_card_model.dart';

part 'quizes_list_event.dart';
part 'quizes_list_state.dart';

class QuizesListBloc extends Bloc<QuizesListEvent, QuizesListState> {
  final _quizManager = QuizDatabaseService();

  QuizesListBloc() : super(QuizesListInitial()) {
    on<QuizesListStarted>(
      (event, map) async {
        try {
          map(QuizesListLoadInProgress());
          final quizes = await _quizManager.getAll();
          final quizCardModels = quizes
              .map((quiz) => QuizCardModel(
                    id: quiz.id,
                    name: quiz.name,
                    length: quiz.length!,
                  ))
              .toList();

          map(QuizesListLoadSuccess(quizCardModels));
        } catch (e) {
          log(e.toString());
          map(QuizesListLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );

    on<QuizesListQuizDeletePressed>(
      (event, map) async {
        try {
          await _quizManager.delete(event.id);
          map(QuizesListQuizDeleteSuccess());
        } catch (e) {
          log(e.toString());
          map(QuizesListQuizDeleteFailure());
        }
      },
    );
  }
}
