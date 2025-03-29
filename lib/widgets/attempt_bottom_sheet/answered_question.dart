import 'package:flutter/material.dart';

import '../../models/question_model.dart';

class AnsweredQuestion extends StatelessWidget {
  const AnsweredQuestion({
    super.key,
    required this.question,
    required this.position,
  });

  final QuestionModel question;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$position) ${question.question}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        for (final variant in question.variants.entries)
          if (variant.key == 1)
            Text(
              '• ${variant.value}',
              style: TextStyle(color: Colors.green),
            )
          else if (variant.key == question.selectedVariant)
            Text(
              '• ${variant.value}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )
          else
            Text('• ${variant.value}')
      ],
    );
  }
}
