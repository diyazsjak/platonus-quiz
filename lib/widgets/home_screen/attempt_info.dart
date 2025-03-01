import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../models/attempt_model.dart';
import '../../services/settings_service.dart';

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
          _ReplayButton(attempt),
        ],
      ),
    );
  }
}

class _ReplayButton extends StatefulWidget {
  final AttemptModel attempt;

  const _ReplayButton(this.attempt);

  @override
  State<_ReplayButton> createState() => __ReplayButtonState();
}

class __ReplayButtonState extends State<_ReplayButton> {
  final _settingsService = SettingsService();
  late bool _shuffleQuestions = _settingsService.shuffleAttemptQuestions;

  void _onShuffleChanged(bool value) async {
    setState(() => _shuffleQuestions = value);
    await _settingsService.setshuffleAttemptQuestions(value);
  }

  void _onReplayPressed(BuildContext context) {
    context.read<QuizBloc>().add(QuizAttemptRetrySelected(
          attempt: widget.attempt,
          shuffle: _shuffleQuestions,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              value: _shuffleQuestions,
              title: Text('Shuffle questions'),
              onChanged: _onShuffleChanged,
              secondary: Icon(Icons.shuffle_rounded),
            ),
            SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => _onReplayPressed(context),
              label: Text('Start quiz'),
              icon: Icon(Icons.start_outlined, size: 22),
            ),
          ],
        ),
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
