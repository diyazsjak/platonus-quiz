import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../models/attempt_model.dart';
import '../../services/settings_service.dart';

class AttemptReplayButton extends StatefulWidget {
  final AttemptModel attempt;

  const AttemptReplayButton(this.attempt, {super.key});

  @override
  State<AttemptReplayButton> createState() => _AttemptReplayButtonState();
}

class _AttemptReplayButtonState extends State<AttemptReplayButton> {
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
      elevation: 5,
      color: Theme.of(context).colorScheme.surface,
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
