import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';

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
              final question = state.questions[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      for (final variant in question.variants)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${variant[0].toUpperCase()}${variant.substring(1)}',
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
