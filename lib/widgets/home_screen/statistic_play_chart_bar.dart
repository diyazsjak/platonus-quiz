import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/completed_quiz_model.dart';

class StatisticPlayChartBar extends StatelessWidget {
  final CompletedQuizModel quiz;

  const StatisticPlayChartBar(this.quiz, {super.key});

  @override
  Widget build(BuildContext context) {
    final score = (quiz.rightQuestionCount * 100) / quiz.questionCount;
    final width = 20.0;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Skeleton.shade(
          child: CustomPaint(
            size: Size(width, constraints.maxHeight),
            painter: _BarChartWithoutBgPainter(
              score: score.round(),
              height: constraints.maxHeight,
              width: width,
              bgColor: Theme.of(context).colorScheme.primaryContainer,
              fgColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}

class _BarChartWithBgPainter extends CustomPainter {
  final int score;
  final double height;
  final double width;
  final Color bgColor;
  final Color fgColor;

  _BarChartWithBgPainter({
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

    final backgroundRect = Rect.fromLTWH(0, top, width, barHeight);
    final foregroundRect = Rect.fromLTWH(
      0,
      height - filledHeight,
      width,
      filledHeight,
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
  final int score;
  final double height;
  final double width;
  final Color bgColor;
  final Color fgColor;

  _BarChartWithoutBgPainter({
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
    final foregroundRect = Rect.fromLTWH(
      0,
      height - barHeight,
      width,
      barHeight,
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
