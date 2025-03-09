import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AttemptResultCard extends StatelessWidget {
  const AttemptResultCard({
    super.key,
    required this.rightQuestionCount,
    required this.totalQuestionCount,
  });

  final int rightQuestionCount;
  final int totalQuestionCount;

  @override
  Widget build(BuildContext context) {
    final score = (rightQuestionCount * 100) / totalQuestionCount;

    return Skeleton.keep(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _AttemptData(
                    label: 'Score',
                    value: score.toStringAsFixed(1),
                  ),
                ),
                VerticalDivider(indent: 4, endIndent: 4),
                Expanded(
                  child: _AttemptData(
                    label: 'Correct',
                    value: '$rightQuestionCount',
                  ),
                ),
                VerticalDivider(indent: 4, endIndent: 4),
                Expanded(
                  child: _AttemptData(
                    label: 'Total',
                    value: '$totalQuestionCount',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AttemptData extends StatelessWidget {
  final String label;
  final String value;

  const _AttemptData({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
