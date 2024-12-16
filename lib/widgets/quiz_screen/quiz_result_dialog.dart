import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/ongoing_quiz/ongoing_quiz_bloc.dart';
import '../../core/constants.dart';

class QuizResult extends StatelessWidget {
  final int quizLength;
  final int rightQuestions;

  const QuizResult({
    super.key,
    required this.quizLength,
    required this.rightQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final grade = ((rightQuestions * 100) / quizLength).round();
    const scoreBarLength = 180.0;
    const titleTextStyle = TextStyle(fontWeight: FontWeight.bold);
    const scoreTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

    return AlertDialog(
      elevation: 10,
      title: const Center(child: Text("Quiz completed", style: titleTextStyle)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Right answers: $rightQuestions out of $quizLength'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Column(
                children: [
                  Text('$grade', style: scoreTextStyle),
                  const Text('Score'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: scoreBarLength,
              child: Stack(
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Container(
                    height: 14,
                    width: scoreBarLength * (grade / 100),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName(Constants.homeRoute),
            );
          },
          child: const Text('Close quiz'),
        ),
        FilledButton(
          onPressed: () {
            context.read<OngoingQuizBloc>().add(OngoingQuizRestarted());
            Navigator.pop(context);
          },
          child: const Text('Try again'),
        ),
      ],
    );
  }
}
