

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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
    Rect rect = Rect.fromLTWH(50, 50, 200, 100);
    Paint paint = Paint()..color = Colors.blue;
    paint..strokeWidth = 7;
    paint..strokeCap = StrokeCap.round;
    List<Offset> points = [Offset(50, 50), Offset(200, 200),Offset(300, 200)];
    canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
