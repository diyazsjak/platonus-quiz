import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/quizes_list/quizes_list_bloc.dart';

class QuizCardDeleteIcon extends StatelessWidget {
  final int quizId;

  const QuizCardDeleteIcon({super.key, required this.quizId});

  void _onDeleteTap(BuildContext context) {
    context.read<QuizesListBloc>().add(QuizesListQuizDeletePressed(quizId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizesListBloc, QuizesListState>(
      buildWhen: (previous, current) {
        return (current is QuizesListQuizDeleteInProgress ||
            current is QuizesListQuizDeleteSuccess ||
            current is QuizesListQuizDeleteFailure);
      },
      builder: (BuildContext context, QuizesListState state) {
        final isDeleteInProgress =
            (state is QuizesListQuizDeleteInProgress && state.quizId == quizId);

        return Skeleton.shade(
          child: TextButton.icon(
            onPressed: isDeleteInProgress ? null : () => _onDeleteTap(context),
            icon: isDeleteInProgress
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Icon(
                    Icons.delete_outline_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
            label: Text(
              'Delete quiz',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        );
      },
    );
  }
}
