import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/attempt_questions/attempt_questions_bloc.dart';
import '../../models/attempt_model.dart';
import '../../models/question_model.dart';
import '../../screens/attempt_questions_screen.dart';
import 'answered_question.dart';
import 'attempt_result_card.dart';

final _fakeVariant = 'Fake variant';

class AttemptInfoQuestions extends StatelessWidget {
  const AttemptInfoQuestions({super.key, required this.attempt});

  final AttemptModel attempt;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttemptQuestionsBloc>(
      create: (BuildContext context) {
        return AttemptQuestionsBloc()
          ..add(AttemptQuestionsStarted(attempt.questionsId));
      },
      child: BlocBuilder<AttemptQuestionsBloc, AttemptQuestionsState>(
        builder: (context, state) {
          if (state is AttemptQuestionsLoadInProgress) {
            final fakeQuestions = List.filled(
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
              child: Skeletonizer(
                child: _AttemptQuestions(
                  attempt.rightQuestionCount,
                  attempt.questionCount,
                  fakeQuestions,
                ),
              ),
            );
          } else if (state is AttemptQuestionsLoadSuccess) {
            return Flexible(
              child: _AttemptQuestions(
                attempt.rightQuestionCount,
                attempt.questionCount,
                state.questions,
              ),
            );
          } else {
            return Text('Couldn\'t load your answers');
          }
        },
      ),
    );
  }
}

class _AttemptQuestions extends StatelessWidget {
  const _AttemptQuestions(
    this.rightQuestionCount,
    this.totalQuestionCount,
    this.questions,
  );

  final int rightQuestionCount;
  final int totalQuestionCount;
  final List<QuestionModel> questions;

  void _pushAttemptQuestionsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AttemptQuestionsScreen(
            questions: questions,
            totalQuestions: totalQuestionCount,
            rightQuestions: rightQuestionCount,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const maxQuestions = 10;
    final moreThanMaxQuestions = questions.length > maxQuestions;

    return ListView.separated(
      itemCount: maxQuestions + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return AttemptResultCard(
            rightQuestionCount: rightQuestionCount,
            totalQuestionCount: totalQuestionCount,
          );
        }
        if (index == 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your answers',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
                Visibility.maintain(
                  visible: moreThanMaxQuestions,
                  child: TextButton(
                    onPressed: () => (moreThanMaxQuestions)
                        ? _pushAttemptQuestionsScreen(context)
                        : null,
                    child: Text('See all'),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnsweredQuestion(
            question: questions[index - 2],
            position: index - 1,
          ),
        );
      },
      separatorBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(height: 16);
        } else if (index == 1) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              height: .8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
          );
        }

        return Divider(thickness: .8, height: 24, indent: 12, endIndent: 12);
      },
    );
  }
}
