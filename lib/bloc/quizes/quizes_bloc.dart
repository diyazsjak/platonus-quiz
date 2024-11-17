import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../database/quiz_manager.dart';

part 'quizes_event.dart';
part 'quizes_state.dart';

class QuizesBloc extends Bloc<QuizesEvent, QuizesState> {
  final _quizManager = QuizManager();

  QuizesBloc() : super(QuizesInitial()) {
    on<QuizesStarted>(
      (event, map) async {
        try {
          map(QuizesLoadInProgress());
          final quizes = await _quizManager.getAll();
          final Map<int, String> quizesMap = {
            for (final quiz in quizes) quiz.id: quiz.name,
          };

          map(QuizesLoadSuccess(quizesMap));
        } catch (e) {
          map(QuizesLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );
  }
}
