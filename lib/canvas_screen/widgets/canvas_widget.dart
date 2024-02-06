import 'dart:ui';

import 'package:cad_web_sketcher/repo/models/models.dart';
import 'package:flutter/material.dart';

class CanvasWidget extends StatelessWidget {
  CanvasWidget({super.key, required this.figure});

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
    //TODO add save to png
    //TODO add len and angle markers

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );
    const textSpan = TextSpan(
      text: 'Hello, world.',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    Paint paintLines = Paint()..color = Colors.grey.shade700;
    paintLines.strokeWidth = 3;
    paintLines.strokeCap = StrokeCap.round;
    Paint paintPoints = Paint()..color = Colors.red;
    paintPoints.strokeWidth = 5;
    paintPoints.strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, figure.listToDraw(), paintLines);
    canvas.drawPoints(PointMode.points, figure.listToDraw(), paintPoints);

    textPainter.paint(canvas, figure.listToDraw()[3]);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
