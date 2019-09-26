import 'package:flutter/material.dart';

class LinearPainter extends CustomPainter {
  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final double lineWidth;
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  LinearPainter(
      {this.lineWidth,
      this.progress,
      this.progressColor,
      this.backgroundColor}) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = lineWidth;

    _paintLine.color = progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth = lineWidth;
    _paintLine.strokeCap = StrokeCap.round;
    _paintBackground.strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0.0, size.height);

    final progressOffset = Offset(0.0, size.height * (1 - progress));

    canvas.drawLine(
        Offset(0.0, 0.0), Offset(0.0, size.height), _paintBackground);

    canvas.drawLine(start, progressOffset, _paintLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
