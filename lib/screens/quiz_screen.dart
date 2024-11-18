import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/quiz/quiz_bloc.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void _showQuizCompletedModal(BuildContext context, int rightQuestionsCount) {
    final quizLength = context.read<QuizBloc>().currentQuiz!.questions.length;
    final answerRatio = '$rightQuestionsCount/$quizLength';
    final grade = ((rightQuestionsCount * 100) / quizLength).round();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Quiz completed"),
          content: Text(
              "You got right $answerRatio questions. Your grade is $grade."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Skeleton.keep(child: Text('Quiz'))),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (BuildContext context, QuizState state) {
          if (state is QuizCompleteSuccess) {
            _showQuizCompletedModal(context, state.rightQuestionsCount);
          }
        },
        buildWhen: (previous, current) {
          return (current is QuizLoadInProgress || current is QuizLoadSuccess);
        },
        builder: (BuildContext context, QuizState state) {
          if (state is QuizLoadInProgress) {
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
                ));
            final fakeQuiz = QuizModel(
              quizName: BoneMock.fullName,
              questions: fakeQuestions,
            );
            return Skeletonizer(child: _Quiz(fakeQuiz));
          } else if (state is QuizLoadSuccess) {
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
          Text(
            '$length questions',
            style: const TextStyle(fontSize: 16),
          ),
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

        return QuestionCard(
          question: quiz.questions[index - 1],
          count: index,
        );
      },
    );
  }
}
