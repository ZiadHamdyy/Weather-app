import 'package:flutter/material.dart';
import 'dart:math';

class CircleLevel extends StatelessWidget {
  final double percentage;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final TextStyle textStyle;

  const CircleLevel({
    super.key,
    required this.percentage,
    this.size = 150.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
  }) : assert(percentage >= 0 && percentage <= 100, 'Percentage must be between 0 and 100');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Circle
          CustomPaint(
            size: Size(size, size),
            painter: CircleLevelPainter(
              percentage: percentage,
              backgroundColor: backgroundColor,
              progressColor: progressColor,
            ),
          ),
          // Percentage Text
          Text(
            '${percentage.toInt()}%',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class CircleLevelPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;

  CircleLevelPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background Circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress Arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    final angle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from the top
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redraw whenever the percentage changes
  }
}
