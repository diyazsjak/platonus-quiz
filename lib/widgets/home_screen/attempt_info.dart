import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../models/attempt_model.dart';

class AttemptInfo extends StatelessWidget {
  final AttemptModel attempt;

  const AttemptInfo(this.attempt, {super.key});

  void _onReplayPressed(BuildContext context) {
    context.read<QuizBloc>().add(QuizAttemptRetrySelected(attempt: attempt));
  }

  @override
  Widget build(BuildContext context) {
    final score = (attempt.rightQuestionCount * 100) / attempt.questionCount;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(attempt.playedAt),
          SizedBox(height: 16),
          Card(
            elevation: 3,
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
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
          SizedBox(height: 32),
          FilledButton(
            onPressed: () => _onReplayPressed(context),
            child: Text('Replay'),
          ),
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
