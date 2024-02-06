import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../repo/models/figure.dart';

class MyCanvasWidget extends StatelessWidget {
  MyCanvasWidget({super.key, required this.figure});

  final Figure figure;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(figure),
    );
  }
}

class MyPainter extends CustomPainter {
  final Figure figure;

  MyPainter(this.figure);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.grey.shade700;
    paint.strokeWidth = 3;
    paint.strokeCap = StrokeCap.round;

    canvas.drawPoints(ui.PointMode.polygon, figure.listToDraw(), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
