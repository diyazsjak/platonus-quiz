import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ongoing_quiz/ongoing_quiz_bloc.dart';
import '../models/question_model.dart';

class QuizQuestionsGrid extends StatefulWidget {
  final Function(int) onQuestionTap;

  const QuizQuestionsGrid({super.key, required this.onQuestionTap});

  @override
  State<QuizQuestionsGrid> createState() => _QuizQuestionsGridState();
}

class _QuizQuestionsGridState extends State<QuizQuestionsGrid> {
  late final questions = context.read<OngoingQuizBloc>().currentQuiz!.questions;

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
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.spaceEvenly,
              children: List.generate(
                (questions.length),
                (index) {
                  return GestureDetector(
                    onTap: () => widget.onQuestionTap(index),
                    child: Container(
                      height: constraints.maxWidth / 10,
                      width: constraints.maxWidth / 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: getQuestionColor(context, questions[index]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: getTextColor(questions[index])),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
