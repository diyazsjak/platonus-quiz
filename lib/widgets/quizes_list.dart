import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/quiz/ongoing_quiz_bloc.dart';
import '../bloc/quizes/quizes_list_bloc.dart';
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
    return BlocConsumer<QuizesListBloc, QuizesListState>(
      listener: (BuildContext context, QuizesListState state) {
        if (state is QuizesListQuizDeleteSuccess) {
          showSuccessSnackbar(context, 'You\'ve successfully deleted quiz');
        } else if (state is QuizesListQuizDeleteFailure) {
          showErrorSnackbar(context, 'Couldn\'t delete quiz');
          context.read<QuizesListBloc>().add(QuizesListStarted());
        }
      },
      buildWhen: (previous, current) {
        return (current is QuizesListLoadInProgress ||
            current is QuizesListLoadFailure ||
            current is QuizesListLoadSuccess);
      },
      builder: (BuildContext context, QuizesListState state) {
        if (state is QuizesListLoadInProgress) {
          final fakeQuizes = List.filled(
            4,
            QuizCardModel(id: -1, name: BoneMock.words(4), length: 100),
          );
          return Skeletonizer(child: _Quizes(quizes: fakeQuizes));
        } else if (state is QuizesListLoadSuccess) {
          return _Quizes(quizes: state.quizes);
        } else {
          return const Center(child: Text("Couldn't load saved quizes"));
        }
      },
    );
  }
}

class _Quizes extends StatefulWidget {
  final List<QuizCardModel> quizes;

  const _Quizes({required this.quizes});

  @override
  State<_Quizes> createState() => _QuizesState();
}

class _QuizesState extends State<_Quizes> {
  late List<QuizCardModel> quizes = widget.quizes;

  void _onDeleteTap(int quizId, int index) {
    context.read<QuizesListBloc>().add(QuizesListQuizDeletePressed(quizId));
    setState(() => quizes.removeAt(index));
  }

  void _onCardTap(BuildContext context, int id) {
    context.read<OngoingQuizBloc>().add(QuizLocalSelected(quizId: id));
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
          key: ValueKey(index),
          margin: EdgeInsets.zero,
          child: ListTile(
            onTap: () => _onCardTap(context, quizId),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(quizName),
            subtitle: Text('Questions: $quizLength'),
            trailing: Skeleton.shade(
              child: IconButton(
                onPressed: () => _onDeleteTap(quizId, index),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
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
