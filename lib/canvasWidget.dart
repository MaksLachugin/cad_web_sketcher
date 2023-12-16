import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'base/figure.dart';

class MyCanvasWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(), child: SizedBox.square(),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Figure figure = Figure();
    figure.addLine(-30, 100);
    figure.addLine(30, 100);
    figure.addLine(-45, 100);
    figure.addLine(-170, 700);

    Paint paint = Paint()..color = Colors.blue;
    paint..strokeWidth = 7;
    paint..strokeCap = StrokeCap.round;

    canvas.drawPoints(ui.PointMode.polygon, figure.listToDraw(), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
