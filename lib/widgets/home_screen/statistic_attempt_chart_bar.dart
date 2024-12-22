import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/completed_quiz_model.dart';
import 'attempt_info.dart';

class StatisticAttemptChartBar extends StatefulWidget {
  final CompletedQuizModel quiz;

  const StatisticAttemptChartBar(this.quiz, {super.key});

  @override
  State<StatisticAttemptChartBar> createState() =>
      _StatisticAttemptChartBarState();
}

class _StatisticAttemptChartBarState extends State<StatisticAttemptChartBar>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  void _openPlayInfoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AttemptInfo(widget.quiz),
    );
  }

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
    final score =
        (widget.quiz.rightQuestionCount * 100) / widget.quiz.questionCount;
    final width = 20.0;

    return InkWell(
      onTap: () => _openPlayInfoBottomSheet(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Skeleton.shade(
              child: CustomPaint(
                size: Size(width, constraints.maxHeight),
                painter: _BarChartWithoutBgPainter(
                  animation: _animationController,
                  score: score.round(),
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

class _BarChartWithBgPainter extends CustomPainter {
  final Animation<double> animation;
  final int score;
  final double height;
  final double width;
  final Color bgColor;
  final Color fgColor;

  _BarChartWithBgPainter({
    required this.animation,
    required this.score,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.fgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: "$score",
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textX = (width - textPainter.width) / 2;
    final textY = 0.0;
    textPainter.paint(canvas, Offset(textX, textY));

    final top = textPainter.height + 4;
    final barHeight = height - top;
    final filledHeight = (score / 100) * barHeight;
    final animatedBarHeight = animation.value * filledHeight;

    final backgroundRect = Rect.fromLTWH(0, top, width, barHeight);
    final foregroundRect = Rect.fromLTWH(
      0,
      height - animatedBarHeight,
      width,
      animatedBarHeight,
    );

    final radius = Radius.circular(8);
    final backgroundPaint = Paint()..color = bgColor;
    final foregroundPaint = Paint()..color = fgColor;

    canvas.drawRRect(
      RRect.fromRectAndRadius(backgroundRect, radius),
      backgroundPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(foregroundRect, radius),
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BarChartWithoutBgPainter extends CustomPainter {
  final Animation<double> animation;
  final int score;
  final double height;
  final double width;
  final Color bgColor;
  final Color fgColor;

  _BarChartWithoutBgPainter({
    required this.animation,
    required this.score,
    required this.height,
    required this.width,
    required this.bgColor,
    required this.fgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: "$score",
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final availableHeight = height - textPainter.height;
    final barHeight = (score / 100) * availableHeight;
    final animatedBarHeight = animation.value * barHeight;
    final foregroundRect = Rect.fromLTWH(
      0,
      height - animatedBarHeight,
      width,
      animatedBarHeight,
    );

    final radius = Radius.circular(8);
    final foregroundPaint = Paint()..color = fgColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(foregroundRect, radius),
      foregroundPaint,
    );

    final textX = (width - textPainter.width) / 2;
    final textY = height - barHeight - textPainter.height - 4;
    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
