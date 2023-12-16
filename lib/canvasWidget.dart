import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'base/figure.dart';

class MyCanvasWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Figure figure = Figure(Offset(0,0));
    figure.addLine(0, 500);
    figure.addLine(90, 500);
    figure.addLine(180, 500);
    figure.addLine(-90, 500);

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
