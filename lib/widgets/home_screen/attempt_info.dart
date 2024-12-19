import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/completed_quiz_model.dart';

class AttemptInfo extends StatelessWidget {
  final CompletedQuizModel quiz;

  const AttemptInfo(this.quiz, {super.key});

  @override
  Widget build(BuildContext context) {
    final score = (quiz.rightQuestionCount * 100) / quiz.questionCount;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(quiz.playedAt),
          SizedBox(height: 16),
          Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
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
                        value: '${quiz.rightQuestionCount}',
                      ),
                    ),
                    VerticalDivider(indent: 4, endIndent: 4),
                    Expanded(
                      child: _AttemptData(
                        label: 'Total',
                        value: '${quiz.questionCount}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
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
