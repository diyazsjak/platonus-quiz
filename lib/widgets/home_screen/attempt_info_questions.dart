import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/attempt_questions/attempt_questions_bloc.dart';
import '../../models/question_model.dart';

final _fakeVariant = 'Fake variant';

class AttemptInfoQuestions extends StatefulWidget {
  const AttemptInfoQuestions({super.key, required this.attemptQuestionsId});

  final int attemptQuestionsId;

  @override
  State<AttemptInfoQuestions> createState() => _AttemptInfoQuestionsState();
}

class _AttemptInfoQuestionsState extends State<AttemptInfoQuestions> {
  final _bloc = AttemptQuestionsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(AttemptQuestionsStarted(widget.attemptQuestionsId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttemptQuestionsBloc, AttemptQuestionsState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is AttemptQuestionsLoadInProgress) {
          final fakeQuestions0 = List.filled(
            10,
            QuestionModel(
              id: -1,
              question: 'Fake question',
              variants: {
                1: _fakeVariant * (Random().nextInt(2) + 3),
                2: _fakeVariant * (Random().nextInt(2) + 3),
                3: _fakeVariant * (Random().nextInt(2) + 3),
                4: _fakeVariant * (Random().nextInt(2) + 3),
              },
            ),
          );
          return Flexible(
            child: Skeletonizer(child: _AttemptQuestions(fakeQuestions0)),
          );
        } else if (state is AttemptQuestionsLoadSuccess) {
          return Flexible(child: _AttemptQuestions(state.questions));
        } else {
          return Text('Couldn\'t load your answers');
        }
      },
    );
  }
}

class _AttemptQuestions extends StatelessWidget {
  const _AttemptQuestions(this.questions);

  final List<QuestionModel> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return _Question(question: questions[index], position: index + 1);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 24);
      },
    );
  }
}

class _Question extends StatelessWidget {
  const _Question({required this.question, required this.position});

  final QuestionModel question;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$position) ${question.question}'),
        SizedBox(height: 8),
        for (final variant in question.variants.entries)
          if (variant.key == 1)
            Text(
              variant.value,
              style: TextStyle(color: Colors.green),
            )
          else if (variant.key == question.selectedVariant)
            Text(
              variant.value,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )
          else
            Text(variant.value)
      ],
    );
  }
}
