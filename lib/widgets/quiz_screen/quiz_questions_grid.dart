import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../models/question_model.dart';

class QuizQuestionsGrid extends StatefulWidget {
  final Function(int) onQuestionTap;

  const QuizQuestionsGrid({super.key, required this.onQuestionTap});

  @override
  State<QuizQuestionsGrid> createState() => _QuizQuestionsGridState();
}

class _QuizQuestionsGridState extends State<QuizQuestionsGrid> {
  late final questions = context.read<QuizBloc>().currentQuiz!.questions;

  Color getQuestionColor(BuildContext context, QuestionModel question) {
    if (!question.isQuestionAnswered) {
      return Theme.of(context).colorScheme.primaryContainer;
    }

    return (question.selectedVariant == 1) ? Colors.green : Colors.redAccent;
  }

  Color getTextColor(QuestionModel question) {
    return question.isQuestionAnswered ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return Card(
      elevation: 10,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 240),
        child: GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.all(8),
          crossAxisCount: 8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(
            (questions.length),
            (index) {
              return InkWell(
                onTap: () => widget.onQuestionTap(index),
                borderRadius: borderRadius,
                child: Ink(
                  decoration: BoxDecoration(
                    color: getQuestionColor(context, questions[index]),
                    borderRadius: borderRadius,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: getTextColor(questions[index])),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
