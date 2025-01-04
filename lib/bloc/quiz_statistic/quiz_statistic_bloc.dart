import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/quiz_statistic_model.dart';
import '../../services/statistic_database_service.dart';

part 'quiz_statistic_event.dart';
part 'quiz_statistic_state.dart';

class QuizStatisticBloc extends Bloc<QuizStatisticEvent, QuizStatisticState> {
  final _statisticDatabaseService = StatisticDatabaseService();

  QuizStatisticBloc() : super(QuizStatisticInitial()) {
    on<QuizStatisticLoadPressed>(
      (event, map) async {
        try {
          map(QuizStatisticLoadInProgress());
          final id = event.quizId;
          final (statisticData, quizes) =
              await _statisticDatabaseService.get(id);

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

    on<QuizStatisticClearPressed>(
      (event, map) async {
        try {
          map(QuizStatisticClearInProgress(event.quizId));
          await _statisticDatabaseService.delete(event.quizId);
          map(QuizStatisticClearSuccess());
        } catch (e) {
          map(QuizStatisticClearFailure());
        }
      },
    );
  }
}
