import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/quiz/quiz_bloc.dart';

class RestartQuizIconButton extends StatelessWidget {
  const RestartQuizIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (BuildContext context, QuizState state) {
        return IconButton(
          onPressed: () {
            if (state is! QuizUpdateStatInProgress) {
              context.read<QuizBloc>().add(QuizRestarted());
            }
          },
          icon: Skeleton.keep(
            child: const Icon(Icons.restart_alt_rounded),
          ),
        );
      },
    );
  }
}
