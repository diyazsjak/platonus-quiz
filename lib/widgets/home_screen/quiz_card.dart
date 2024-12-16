import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/ongoing_quiz/ongoing_quiz_bloc.dart';
import '../../bloc/quiz_statistic/quiz_statistic_bloc.dart';
import '../../models/quiz_statistic_model.dart';
import 'quiz_card_delete_icon.dart';
import 'statistic_play_chart_bar.dart';

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
          onPressed: () {
            context
                .read<OngoingQuizBloc>()
                .add(OngoingQuizLocalSelected(quizId: widget.quizId));
          },
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
                  child: _Statistic(QuizStatisticModel.fake(), -1),
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

                return _Statistic(state.statistic!, widget.quizId);
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

class _Statistic extends StatelessWidget {
  final int quizId;
  final QuizStatisticModel statistic;

  const _Statistic(this.statistic, this.quizId);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatisticChip('Attempts: ${statistic.playCount}'),
            _StatisticChip('Average: ${statistic.avgScore.toStringAsFixed(1)}'),
            _StatisticChip('Max: ${statistic.highestScore}'),
            _StatisticChip('Min: ${statistic.lowestScore}'),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: statistic.quizes.length,
            itemBuilder: (BuildContext context, int index) {
              return StatisticPlayChartBar(statistic.quizes[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 16);
            },
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: QuizCardDeleteIcon(quizId: quizId),
        ),
      ],
    );
  }
}

class _StatisticChip extends StatelessWidget {
  final String text;

  const _StatisticChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
