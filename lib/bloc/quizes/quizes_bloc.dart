import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/failure.dart';
import '../../database/quiz_manager.dart';
import '../../models/quiz_card_model.dart';

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
          final quizCardModels = quizes
              .map((quiz) => QuizCardModel(
                    id: quiz.id,
                    name: quiz.name,
                    length: quiz.length!,
                  ))
              .toList();

          map(QuizesLoadSuccess(quizCardModels));
        } catch (e) {
          map(QuizesLoadFailure(failure: UnknownDatabaseFailure()));
        }
      },
    );
  }
}
