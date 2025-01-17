import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/quiz_statistic/quiz_statistic_bloc.dart';

class QuizStatisticClearButton extends StatelessWidget {
  final int quizId;

  const QuizStatisticClearButton({super.key, required this.quizId});

  void _onClearTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Clear statistic'),
          content: Text('All statistic will be cleared'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<QuizStatisticBloc>()
                    .add(QuizStatisticClearPressed(quizId));
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizStatisticBloc, QuizStatisticState>(
      buildWhen: (previous, current) {
        return (current is QuizStatisticClearInProgress ||
            current is QuizStatisticClearFailure ||
            current is QuizStatisticClearSuccess);
      },
      builder: (context, state) {
        final isClearInProgress =
            (state is QuizStatisticClearInProgress && state.quizId == quizId);

        return Skeleton.shade(
          child: TextButton.icon(
            onPressed: isClearInProgress ? null : () => _onClearTap(context),
            icon: isClearInProgress
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Icon(Icons.clear_rounded),
            label: Text('Clear statistic'),
          ),
        );
      },
    );
  }
}
