import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/quiz/ongoing_quiz_bloc.dart';
import '../core/constants.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';
import '../util/show_snackbar.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_questions_grid.dart';
import '../widgets/quiz_result_dialog.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OngoingQuizBloc, OngoingQuizState>(
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
    );
  }
}

class _Quiz extends StatefulWidget {
  final QuizModel quiz;

  const _Quiz(this.quiz);

  @override
  State<_Quiz> createState() => _QuizState();
}

class _QuizState extends State<_Quiz> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final OverlayPortalController _overlayController = OverlayPortalController();

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

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exit quiz'),
          content: const Text('You won\'t be able to continue this quiz'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Constants.homeRoute),
                );
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.quiz.questions;
    final systemBarHeight = MediaQuery.viewPaddingOf(context).top;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showExitDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Skeleton.keep(child: Text('Quiz')),
          leading: IconButton(
            onPressed: () => _showExitDialog(),
            icon: const Skeleton.keep(child: Icon(Icons.arrow_back)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () => _overlayController.toggle(),
                icon: const Skeleton.keep(
                  child: Icon(Icons.format_list_bulleted),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<OngoingQuizBloc, OngoingQuizState>(
          buildWhen: (previous, current) => current is OngoingQuizComplete,
          builder: (BuildContext context, OngoingQuizState state) {
            return (state is OngoingQuizComplete)
                ? FloatingActionButton.extended(
                    onPressed: () {
                      _showQuizCompletedModal(
                          context, state.rightQuestionsCount);
                    },
                    heroTag: 'Result',
                    label: const Text('See results'),
                    icon: const Icon(Icons.done_all_rounded),
                  )
                : const SizedBox();
          },
        ),
        body: OverlayPortal(
          controller: _overlayController,
          overlayChildBuilder: (BuildContext context) {
            final topPosition = kToolbarHeight + systemBarHeight;

            return Positioned(
              top: topPosition,
              left: 2,
              right: 2,
              child: TapRegion(
                onTapOutside: (event) {
                  if (event.localPosition.dy < topPosition) return;
                  _overlayController.hide();
                },
                child: QuizQuestionsGrid(
                  onQuestionTap: (int index) {
                    _overlayController.hide();
                    _itemScrollController.jumpTo(index: index + 1);
                  },
                ),
              ),
            );
          },
          child: ScrollablePositionedList.builder(
            itemCount: questions.length + 1,
            itemScrollController: _itemScrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildHeader(widget.quiz.quizName, questions.length);
              }

              return QuestionCard(question: questions[index - 1], count: index);
            },
          ),
        ),
      ),
    );
  }
}
