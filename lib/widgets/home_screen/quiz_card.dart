import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/ongoing_quiz/ongoing_quiz_bloc.dart';
import '../../bloc/quiz_statistic/quiz_statistic_bloc.dart';
import '../../models/quiz_statistic_model.dart';
import 'quiz_card_delete_icon.dart';
import 'quiz_card_statistic.dart';

class QuizesListCard extends StatefulWidget {
  final int quizId;
  final String quizName;
  final int quizLength;

  const QuizesListCard({
    super.key,
    required this.quizId,
    required this.quizName,
    required this.quizLength,
  });

  @override
  State<QuizesListCard> createState() => _QuizesListCardState();
}

class _QuizesListCardState extends State<QuizesListCard> {
  bool _hasStatisticLoaded = false;

  void _getStatistic() {
    context
        .read<QuizStatisticBloc>()
        .add(QuizStatisticLoadPressed(widget.quizId));
  }

  void _startQuiz() {
    context
        .read<OngoingQuizBloc>()
        .add(OngoingQuizLocalSelected(quizId: widget.quizId));
  }

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    final expandedColor = Theme.of(context).colorScheme.surfaceContainerLow;

    return BlocListener<OngoingQuizBloc, OngoingQuizState>(
      listener: (BuildContext context, OngoingQuizState state) {
        if (state is OngoingQuizComplete) {
          if (state.quizId == widget.quizId) _getStatistic();
        }
      },
      child: ExpansionTile(
        onExpansionChanged: (value) {
          if (value && !_hasStatisticLoaded) _getStatistic();
        },
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        controlAffinity: ListTileControlAffinity.leading,
        backgroundColor: expandedColor,
        collapsedBackgroundColor: expandedColor,
        shape: shape,
        collapsedShape: shape,
        title: Text(widget.quizName),
        subtitle: Text('Questions: ${widget.quizLength}'),
        trailing: IconButton(
          onPressed: _startQuiz,
          icon: Icon(
            Icons.start_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        children: [
          BlocBuilder<QuizStatisticBloc, QuizStatisticState>(
            builder: (context, state) {
              if (state is QuizStatisticLoadInProgress) {
                return Skeletonizer(
                  child: QuizCardStatistic(
                    statistic: QuizStatisticModel.fake(),
                    quizId: -1,
                  ),
                );
              }
              if (state is QuizStatisticLoadSuccess) {
                _hasStatisticLoaded = true;
                if (state.statistic == null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No statistics yet'),
                      QuizCardDeleteIcon(quizId: widget.quizId),
                    ],
                  );
                }

                return QuizCardStatistic(
                  statistic: state.statistic!,
                  quizId: widget.quizId,
                );
              } else {
                return Text('Failure');
              }
            },
          ),
        ],
      ),
    );
  }
}
