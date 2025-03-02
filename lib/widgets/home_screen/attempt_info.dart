import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/attempt_model.dart';
import 'attempt_replay_button.dart';

class AttemptInfo extends StatelessWidget {
  final AttemptModel attempt;

  const AttemptInfo(this.attempt, {super.key});

  @override
  Widget build(BuildContext context) {
    final score = (attempt.rightQuestionCount * 100) / attempt.questionCount;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(attempt.playedAt),
          SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
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
                        value: '${attempt.rightQuestionCount}',
                      ),
                    ),
                    VerticalDivider(indent: 4, endIndent: 4),
                    Expanded(
                      child: _AttemptData(
                        label: 'Total',
                        value: '${attempt.questionCount}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          AttemptReplayButton(attempt),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime date;

  const _Header(this.date);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Expanded(
          child: Text(
            '${DateFormat.yMMMd().format(date)} ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              DateFormat.jm().format(date),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
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
