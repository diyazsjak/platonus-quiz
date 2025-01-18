import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/quiz_database_service.dart';

part 'quiz_rename_event.dart';
part 'quiz_rename_state.dart';

class QuizRenameBloc extends Bloc<QuizRenameEvent, QuizRenameState> {
  final _quizService = QuizDatabaseService();

  QuizRenameBloc() : super(QuizRenameInitial()) {
    on<QuizRenamePressed>(
      (event, map) async {
        try {
          map(QuizRenameInProgress());
          await _quizService.rename(event.quizId, event.name);
          map(QuizRenameSuccess(newName: event.name));
        } catch (e) {
          map(QuizRenameFailure());
        }
      },
    );
  }
}
