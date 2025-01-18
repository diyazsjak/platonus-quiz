import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/quiz_statistic_model.dart';
import 'quiz_card_delete_button.dart';
import 'quiz_card_rename_button.dart';
import 'quiz_statistic_clear_button.dart';
import 'statistic_attempt_chart_bar.dart';

class QuizCardStatistic extends StatelessWidget {
  final int quizId;
  final QuizStatisticModel statistic;

  const QuizCardStatistic({
    super.key,
    required this.statistic,
    required this.quizId,
  });

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
        SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: statistic.quizes.length,
            itemBuilder: (BuildContext context, int index) {
              return StatisticAttemptChartBar(statistic.quizes[index]);
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            QuizCardRenameButton(quizId: quizId),
            QuizStatisticClearButton(quizId: quizId),
            QuizCardDeleteButton(quizId: quizId),
          ],
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
