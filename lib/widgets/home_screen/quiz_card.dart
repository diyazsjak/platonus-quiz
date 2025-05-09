import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../bloc/quiz_rename/quiz_rename_bloc.dart';
import '../../bloc/quiz_statistic/quiz_statistic_bloc.dart';
import '../../util/show_snackbar.dart';
import 'quiz_card_delete_button.dart';
import 'quiz_card_rename_button.dart';
import 'quiz_card_statistic.dart';

class QuizCard extends StatefulWidget {
  final int quizId;
  final String quizName;
  final int quizLength;

  const QuizCard({
    super.key,
    required this.quizId,
    required this.quizName,
    required this.quizLength,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  bool _hasStatisticLoaded = false;

  void _getStatistic() {
    context
        .read<QuizStatisticBloc>()
        .add(QuizStatisticLoadPressed(widget.quizId));
  }

  void _startQuiz() {
    context.read<QuizBloc>().add(QuizSelected(quizId: widget.quizId));
  }

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    final expandedColor = Theme.of(context).colorScheme.surfaceContainerLow;

    return BlocListener<QuizBloc, QuizState>(
      listener: (BuildContext context, QuizState state) {
        if (state is QuizComplete) {
          if (state.quizId == widget.quizId) _getStatistic();
        }
      },
      child: ExpansionTile(
        onExpansionChanged: (value) {
          if (value && !_hasStatisticLoaded) _getStatistic();
        },
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        controlAffinity: ListTileControlAffinity.leading,
        backgroundColor: expandedColor,
        collapsedBackgroundColor: expandedColor,
        shape: shape,
        collapsedShape: shape,
        title: _QuizName(widget.quizName),
        subtitle: Text('Questions: ${widget.quizLength}'),
        trailing: IconButton(
          onPressed: _startQuiz,
          icon: Icon(
            Icons.start_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        children: [
          BlocConsumer<QuizStatisticBloc, QuizStatisticState>(
            listener: (BuildContext context, QuizStatisticState state) {
              if (state is QuizStatisticClearFailure) {
                showErrorSnackbar(context, 'Couldn\'t clear statistic');
              }
            },
            buildWhen: (previous, current) {
              return (current is QuizStatisticLoadInProgress ||
                  current is QuizStatisticLoadSuccess ||
                  current is QuizStatisticLoadFailure ||
                  current is QuizStatisticClearSuccess);
            },
            builder: (context, state) {
              if (state is QuizStatisticLoadInProgress) {
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                );
              } else if (state is QuizStatisticLoadSuccess) {
                _hasStatisticLoaded = true;
                if (state.statistic == null) return _NoStatistic(widget.quizId);

                return QuizCardStatistic(
                  statistic: state.statistic!,
                  quizId: widget.quizId,
                );
              } else if (state is QuizStatisticClearSuccess) {
                return _NoStatistic(widget.quizId);
              } else {
                return Text('Failure');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _NoStatistic extends StatelessWidget {
  final int quizId;

  const _NoStatistic(this.quizId);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('No statistics yet'),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            QuizCardRenameButton(quizId: quizId),
            QuizCardDeleteButton(quizId: quizId),
          ],
        ),
      ],
    );
  }
}

class _QuizName extends StatelessWidget {
  final String name;

  const _QuizName(this.name);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizRenameBloc, QuizRenameState>(
      builder: (context, state) {
        if (state is QuizRenameSuccess) {
          return Text(state.newName);
        } else if (state is QuizRenameInProgress) {
          return Skeletonizer(child: Bone.text());
        }

        return Text(name);
      },
    );
  }
}
