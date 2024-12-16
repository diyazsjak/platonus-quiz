import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../bloc/ongoing_quiz/ongoing_quiz_bloc.dart';

class RestartQuizIconButton extends StatelessWidget {
  const RestartQuizIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OngoingQuizBloc, OngoingQuizState>(
      builder: (BuildContext context, OngoingQuizState state) {
        return IconButton(
          onPressed: () {
            if (state is! OngoingQuizUpdateStatInProgress) {
              context.read<OngoingQuizBloc>().add(OngoingQuizRestarted());
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
