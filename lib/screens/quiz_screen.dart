import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platonus_quiz/util/show_snackbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/quiz/ongoing_quiz_bloc.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_result_dialog.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _showQuizCompletedModal(BuildContext context, int rightQuestionsCount) {
    final quizLength =
        context.read<OngoingQuizBloc>().currentQuiz!.questions.length;

    showDialog(
      context: context,
      builder: (context) {
        return QuizResult(
          quizLength: quizLength,
          rightQuestions: rightQuestionsCount,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Skeleton.keep(child: Text('Quiz'))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<OngoingQuizBloc, OngoingQuizState>(
        buildWhen: (previous, current) => current is OngoingQuizComplete,
        builder: (BuildContext context, OngoingQuizState state) {
          return (state is OngoingQuizComplete)
              ? FloatingActionButton.extended(
                  onPressed: () {
                    _showQuizCompletedModal(context, state.rightQuestionsCount);
                  },
                  label: const Text('See results'),
                  icon: const Icon(Icons.done_all_rounded),
                )
              : const SizedBox();
        },
      ),
      body: BlocConsumer<OngoingQuizBloc, OngoingQuizState>(
        listener: (BuildContext context, OngoingQuizState state) {
          if (state is OngoingQuizComplete) {
            showSuccessSnackbar(context, 'You\'ve completed this quiz');
          }
        },
        buildWhen: (previous, current) {
          return (current is OngoingQuizLoadInProgress ||
              current is OngoingQuizLoadSuccess);
        },
        builder: (BuildContext context, OngoingQuizState state) {
          if (state is OngoingQuizLoadInProgress) {
            final fakeQuestions = List.filled(
              3,
              QuestionModel(
                question: BoneMock.paragraph,
                variants: {
                  1: BoneMock.words(6),
                  2: BoneMock.words(10),
                  3: BoneMock.words(12),
                  4: BoneMock.words(9),
                },
              ),
            );
            final fakeQuiz = QuizModel(
              quizName: BoneMock.fullName,
              questions: fakeQuestions,
            );
            return Skeletonizer(child: _Quiz(fakeQuiz));
          } else if (state is OngoingQuizLoadSuccess) {
            return _Quiz(state.quiz);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _Quiz extends StatelessWidget {
  final QuizModel quiz;

  const _Quiz(this.quiz);

  Widget _buildHeader(String quizName, int length) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quizName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text('$length questions', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final length = quiz.questions.length;
    return ListView.builder(
      itemCount: length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildHeader(quiz.quizName, length);
        }

        return QuestionCard(question: quiz.questions[index - 1], count: index);
      },
    );
  }
}
