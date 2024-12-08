import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/quiz_statistic_model.dart';
import '../../services/completed_quiz_database_service.dart';
import '../../services/statistic_database_service.dart';

part 'quiz_statistic_event.dart';
part 'quiz_statistic_state.dart';

class QuizStatisticBloc extends Bloc<QuizStatisticEvent, QuizStatisticState> {
  final _statisticDatabaseService = StatisticDatabaseService();
  final _completedQuizDatabaseService = CompletedQuizDatabaseService();

  QuizStatisticBloc() : super(QuizStatisticInitial()) {
    on<QuizStatisticLoadPressed>(
      (event, map) async {
        try {
          map(QuizStatisticLoadInProgress());
          final id = event.quizId;
          final statisticData = await _statisticDatabaseService.get(id);
          final quizes = await _completedQuizDatabaseService.getAll(id);

          if (statisticData == null) {
            map(QuizStatisticLoadSuccess(null));
            return;
          }

          map(QuizStatisticLoadSuccess(
            QuizStatisticModel.fromDatabase(statisticData, quizes),
          ));
        } catch (e) {
          log(e.toString());
          map(QuizStatisticLoadFailure());
        }
      },
    );
  }
}
