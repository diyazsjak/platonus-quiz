import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (previous, current) => current is QuizLoadSuccess,
      builder: (BuildContext context, QuizState state) {
        if (state is! QuizLoadSuccess) return const SizedBox();

        final length = state.quiz.questions.length;
        return Scaffold(
          appBar: AppBar(title: const Text('Quiz')),
          body: ListView.builder(
            itemCount: length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quiz name: ${state.quiz.quizName}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Questions: $length',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }

              return QuestionCard(question: state.quiz.questions[index - 1]);
            },
          ),
        );
      },
    );
  }
}
