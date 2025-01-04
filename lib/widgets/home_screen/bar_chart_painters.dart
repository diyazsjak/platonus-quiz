import 'package:flutter/material.dart';

class BarChartWithBgPainter extends CustomPainter {
  final Animation<double>? animation;
  final int score;
  final double height;
  final double width;
  final Color bgColor;
  final Color fgColor;

  BarChartWithBgPainter({
    this.animation,
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
    final foregroundRect = (animation != null)
        ? Rect.fromLTWH(
            0,
            height - (animation!.value * filledHeight),
            width,
            animation!.value * filledHeight,
          )
        : Rect.fromLTWH(
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

class BarChartWithoutBgPainter extends CustomPainter {
  final Animation<double>? animation;
  final int score;
  final double height;
  final double width;
  final Color fgColor;

  BarChartWithoutBgPainter({
    this.animation,
    required this.score,
    required this.height,
    required this.width,
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

    final availableHeight = height - textPainter.height - 4;
    final barHeight = (score / 100) * availableHeight;
    final foregroundRect = (animation != null)
        ? Rect.fromLTWH(
            0,
            height - (animation!.value * barHeight),
            width,
            animation!.value * barHeight,
          )
        : Rect.fromLTWH(
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
    final textY = (animation == null)
        ? (height - barHeight - textPainter.height - 4)
        : (height - textPainter.height - 4) - (animation!.value * barHeight);
    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
