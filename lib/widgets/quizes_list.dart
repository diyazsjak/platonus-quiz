import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz/quiz_bloc.dart';
import '../bloc/quizes/quizes_bloc.dart';
import '../models/quiz_card_model.dart';
import '../util/show_snackbar.dart';

class QuizesList extends StatefulWidget {
  const QuizesList({super.key});

  @override
  State<QuizesList> createState() => _QuizesListState();
}

class _QuizesListState extends State<QuizesList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizesBloc, QuizesState>(
      listener: (BuildContext context, QuizesState state) {
        if (state is QuizesQuizDeleteSuccess) {
          showSuccessSnackbar(context, 'You\'ve successfully deleted quiz');
        } else if (state is QuizesQuizDeleteFailure) {
          showSnackbar(context, 'Couldn\'t delete quiz');
          context.read<QuizesBloc>().add(QuizesStarted());
        }
      },
      buildWhen: (previous, current) {
        return (current is QuizesLoadInProgress ||
            current is QuizesLoadFailure ||
            current is QuizesLoadSuccess);
      },
      builder: (BuildContext context, QuizesState state) {
        if (state is QuizesLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuizesLoadSuccess) {
          return Quizes(quizes: state.quizes);
        } else {
          return const Center(child: Text("Couldn't load saved quizes"));
        }
      },
    );
  }
}

class Quizes extends StatefulWidget {
  final List<QuizCardModel> quizes;

  const Quizes({super.key, required this.quizes});

  @override
  State<Quizes> createState() => _QuizesState();
}

class _QuizesState extends State<Quizes> {
  late List<QuizCardModel> quizes = widget.quizes;

  void _onDeleteTap(int quizId, int index) {
    context.read<QuizesBloc>().add(QuizesQuizDeletePressed(quizId));
    setState(() => quizes.removeAt(index));
  }

  void _onCardTap(BuildContext context, int id) {
    context.read<QuizBloc>().add(QuizLocalSelected(quizId: id));
  }

  @override
  Widget build(BuildContext context) {
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
          key: UniqueKey(),
          margin: EdgeInsets.zero,
          child: ListTile(
            onTap: () => _onCardTap(context, quizId),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(quizName),
            subtitle: Text('Questions: $quizLength'),
            trailing: IconButton(
              onPressed: () => _onDeleteTap(quizId, index),
              icon: const Icon(Icons.delete_outline),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 12);
      },
    );
  }
}
