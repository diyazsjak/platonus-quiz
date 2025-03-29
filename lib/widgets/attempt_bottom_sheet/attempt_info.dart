import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/attempt_model.dart';
import 'attempt_info_questions.dart';
import 'attempt_replay_button.dart';

class AttemptInfo extends StatelessWidget {
  final AttemptModel attempt;

  const AttemptInfo(this.attempt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _Header(attempt.playedAt),
            AttemptInfoQuestions(attempt: attempt),
            Visibility.maintain(
              visible: false,
              child: AttemptReplayButton(attempt),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 8,
          left: 8,
          child: AttemptReplayButton(attempt),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime date;

  const _Header(this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
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
        ],
      ),
    );
  }
}
