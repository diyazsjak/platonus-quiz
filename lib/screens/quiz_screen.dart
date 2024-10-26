import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: BlocBuilder<QuizBloc, QuizState>(
        buildWhen: (previous, current) => current is QuizLoadSuccess,
        builder: (BuildContext context, QuizState state) {
          if (state is! QuizLoadSuccess) return const SizedBox();

          return ListView.builder(
            itemCount: state.questions.length,
            itemBuilder: (BuildContext context, int index) {
              return QuestionCard(question: state.questions[index]);
            },
          );
        },
      ),
    );
  }
}
