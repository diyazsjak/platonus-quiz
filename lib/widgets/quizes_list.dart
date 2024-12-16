import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/quiz_statistic/quiz_statistic_bloc.dart';
import '../bloc/quizes_list/quizes_list_bloc.dart';
import '../models/quiz_card_model.dart';
import '../util/show_snackbar.dart';
import 'quiz_card.dart';

class QuizesList extends StatefulWidget {
  const QuizesList({super.key});

  @override
  State<QuizesList> createState() => _QuizesListState();
}

class _QuizesListState extends State<QuizesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizesListBloc, QuizesListState>(
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

  @override
  void didUpdateWidget(covariant _Quizes oldWidget) {
    if (oldWidget.quizes != widget.quizes) {
      quizes = widget.quizes;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (quizes.isEmpty) {
      return const Center(child: Text('You have no saved quizes yet'));
    }

    return BlocListener<QuizesListBloc, QuizesListState>(
      listener: (BuildContext context, QuizesListState state) {
        if (state is QuizesListQuizDeleteSuccess) {
          showSuccessSnackbar(context, 'You\'ve successfully deleted quiz');
          setState(() {
            quizes.removeWhere((quiz) => quiz.id == state.quizId);
          });
        } else if (state is QuizesListQuizDeleteFailure) {
          showErrorSnackbar(context, 'Couldn\'t delete quiz');
          context.read<QuizesListBloc>().add(QuizesListStarted());
        }
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: quizes.length,
        itemBuilder: (context, index) {
          final quizId = quizes[index].id;
          final quizName = quizes[index].name;
          final quizLength = quizes[index].length;

          return BlocProvider(
            create: (context) => QuizStatisticBloc(),
            child: QuizesListCard(
              quizId: quizId,
              quizName: quizName,
              quizLength: quizLength,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }
}
