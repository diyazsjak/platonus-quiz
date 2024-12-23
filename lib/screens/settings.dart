import 'package:flutter/material.dart';

import '../widgets/settings_bottom_sheet/attempt_bar_type_radio.dart';
import '../widgets/settings_bottom_sheet/question_limit_slider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          QuestionLimitSlider(),
          const SizedBox(height: 16),
          AttemptBarTypeRadio(),
        ],
      ),
    );
  }
}
