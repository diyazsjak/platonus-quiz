import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _questionLimitValue = 25;

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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
            onChanged: (value) {
              setState(() {
                _questionLimitValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
