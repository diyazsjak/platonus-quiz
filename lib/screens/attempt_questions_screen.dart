import 'package:flutter/material.dart';

import '../models/question_model.dart';
import '../widgets/attempt_bottom_sheet/answered_question.dart';

class AttemptQuestionsScreen extends StatelessWidget {
  const AttemptQuestionsScreen({super.key, required this.questions});

  final List<QuestionModel> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attempt answers')),
      body: ListView.separated(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnsweredQuestion(
                question: questions[index],
                position: index + 1,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12);
        },
      ),
    );
  }
}
