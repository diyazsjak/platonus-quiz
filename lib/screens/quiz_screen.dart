import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz/quiz_bloc.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

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
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (BuildContext context, QuizState state) {
        if (state is QuizCompleteSuccess) {
          _showQuizCompletedModal(context, state.rightQuestionsCount);
        }
      },
      buildWhen: (previous, current) => current is QuizLoadSuccess,
      builder: (BuildContext context, QuizState state) {
        if (state is! QuizLoadSuccess) return const SizedBox();

        final length = state.quiz.questions.length;
        return Scaffold(
          appBar: AppBar(title: const Text('Quiz')),
          body: ListView.builder(
            itemCount: length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildHeader(state.quiz.quizName, length);
              }

              return QuestionCard(
                question: state.quiz.questions[index - 1],
                count: index,
              );
            },
          ),
        );
      },
    );
  }
}
