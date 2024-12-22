import 'package:flutter/material.dart';

import '../../services/settings_service.dart';

class QuestionLimitSlider extends StatefulWidget {
  const QuestionLimitSlider({super.key});

  @override
  State<QuestionLimitSlider> createState() => _QuestionLimitSliderState();
}

class _QuestionLimitSliderState extends State<QuestionLimitSlider> {
  final settingsService = SettingsService();
  late double _questionLimitValue = settingsService.questionLimit;

  void _onQuestionLimitChanged(double value) async {
    setState(() {
      _questionLimitValue = value;
    });
  }

  void _saveQuestionLimit(double value) async {
    await settingsService.setQuestionLimit(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quiz questions limit',
                style: TextStyle(fontSize: 16),
              ),
              Text(_questionLimitValue.toInt().toString()),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _questionLimitValue,
          min: 10,
          max: 100,
          divisions: 18,
          onChanged: (value) => _onQuestionLimitChanged(value),
          onChangeEnd: (value) => _saveQuestionLimit(value),
        ),
      ],
    );
  }
}
