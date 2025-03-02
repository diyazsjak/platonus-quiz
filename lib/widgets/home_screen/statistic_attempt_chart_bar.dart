import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/attempt_bar_type/attempt_bar_type_cubit.dart';
import '../../models/attempt_model.dart';
import 'attempt_info.dart';
import 'bar_chart_painters.dart';

class StatisticAttemptChartBar extends StatelessWidget {
  final AttemptModel quiz;

  const StatisticAttemptChartBar(this.quiz, {super.key});

  void _openPlayInfoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: AttemptInfo(quiz),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final score = (quiz.rightQuestionCount * 100) / quiz.questionCount;

    return BlocBuilder<AttemptBarTypeCubit, AttemptBarTypeState>(
      builder: (BuildContext context, AttemptBarTypeState state) {
        if (state is AttemptBarTypeLoadSuccess &&
            state.type == AttemptBarType.withoutBackground) {
          return _AnimatedBarWithoutBackground(score, _openPlayInfoBottomSheet);
        } else {
          return _AnimatedBarWithBackground(score, _openPlayInfoBottomSheet);
        }
      },
    );
  }
}

class _AnimatedBarWithoutBackground extends StatefulWidget {
  final double score;
  final Function(BuildContext) onTap;

  const _AnimatedBarWithoutBackground(this.score, this.onTap);

  @override
  State<_AnimatedBarWithoutBackground> createState() =>
      __AnimatedBarWithoutBackgroundState();
}

class __AnimatedBarWithoutBackgroundState
    extends State<_AnimatedBarWithoutBackground>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void initState() {
    _animationController.addListener(() => setState(() {}));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = 20.0;

    return InkWell(
      onTap: () => widget.onTap(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Skeleton.shade(
              child: CustomPaint(
                size: Size(width, constraints.maxHeight),
                painter: BarChartWithoutBgPainter(
                  animation: _animationController,
                  score: widget.score.round(),
                  height: constraints.maxHeight,
                  width: width,
                  fgColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedBarWithBackground extends StatefulWidget {
  final double score;
  final Function(BuildContext) onTap;

  const _AnimatedBarWithBackground(this.score, this.onTap);

  @override
  State<_AnimatedBarWithBackground> createState() =>
      __AnimatedBarWithBackgroundState();
}

class __AnimatedBarWithBackgroundState extends State<_AnimatedBarWithBackground>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void initState() {
    _animationController.addListener(() => setState(() {}));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = 20.0;

    return InkWell(
      onTap: () => widget.onTap(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Skeleton.shade(
              child: CustomPaint(
                size: Size(width, constraints.maxHeight),
                painter: BarChartWithBgPainter(
                  animation: _animationController,
                  score: widget.score.round(),
                  height: constraints.maxHeight,
                  width: width,
                  bgColor: Theme.of(context).colorScheme.primaryContainer,
                  fgColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
