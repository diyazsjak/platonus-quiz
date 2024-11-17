import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz/quiz_bloc.dart';
import '../bloc/quizes/quizes_bloc.dart';

class QuizesList extends StatefulWidget {
  const QuizesList({super.key});

  @override
  State<QuizesList> createState() => _QuizesListState();
}

class _QuizesListState extends State<QuizesList> {
  void _onTap(BuildContext context, int id) {
    context.read<QuizBloc>().add(QuizLocalSelected(quizId: id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizesBloc, QuizesState>(
      builder: (BuildContext context, QuizesState state) {
        if (state is QuizesLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuizesLoadSuccess) {
          final quizes = state.quizes;

          if (quizes.isEmpty) {
            return const Center(child: Text('You have no saved quizes yet'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: quizes.length,
            itemBuilder: (context, index) {
              final quizId = quizes[index].id;
              final quizName = quizes[index].name;
              final quizLength = quizes[index].length;

              return Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () => _onTap(context, quizId),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(quizName),
                  subtitle: Text('Questions: $quizLength'),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
          );
        } else {
          return const Center(child: Text("Couldn't load saved quizes"));
        }
      },
    );
  }
}
