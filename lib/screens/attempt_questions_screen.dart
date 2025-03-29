import 'package:flutter/material.dart';

import '../models/question_model.dart';
import '../widgets/attempt_bottom_sheet/answered_question.dart';

class AttemptQuestionsScreen extends StatelessWidget {
  const AttemptQuestionsScreen({
    super.key,
    required this.questions,
    required this.totalQuestions,
    required this.rightQuestions,
  });

  final List<QuestionModel> questions;
  final int totalQuestions;
  final int rightQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attempt answers'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text('$rightQuestions/$totalQuestions'),
          ),
        ],
      ),
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
