import 'dart:ui';

import 'package:cad_web_sketcher/repo/models/canvas_model.dart';
import 'package:flutter/material.dart';

class CanvasWidget extends StatelessWidget {
  const CanvasWidget({super.key, required this.canvasModel});

  final CanvasModel canvasModel;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(canvasModel),
    );
  }
}

class MyPainter extends CustomPainter {
  final CanvasModel canvasModel;
  Paint get linePainter {
    Paint painter = Paint()..color = Colors.grey.shade700;
    painter.strokeWidth = 2;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  Paint get pointPainter {
    Paint painter = Paint()..color = Colors.red;
    painter.strokeWidth = 4;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  Paint get colorPainter {
    Paint painter = Paint()..color = Colors.blue;
    painter.strokeWidth = 5;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  MyPainter(this.canvasModel);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> pointsToDraw = canvasModel.getPointsToDraw(size, 0.8);
    drawFigure(canvas, pointsToDraw, size);
    drawListPointAndText(
        size, canvas, canvasModel.angelTextPointsToDraw(pointsToDraw, size));
    drawListPointAndText(
        size, canvas, canvasModel.lenTextPointsToDraw(pointsToDraw, size));
  }

  void drawCanvasModel(CanvasModel cm) {}

  void drawFigure(Canvas canvas, List<Offset> points, Size size) {
    canvas.drawPoints(PointMode.polygon, points, linePainter);
    canvas.drawPoints(PointMode.points, points, pointPainter);
    canvas.drawPoints(PointMode.points, [canvasModel.getCenterOfFigure(points)],
        colorPainter);
  }

  void drawListPointAndText(
      Size size, Canvas canvas, List<(Offset, String)> elements) {
    for (var (point, text) in elements) {
      var textStyle = const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
      var textSpan = TextSpan(
        text: text,
        style: textStyle,
      );
      var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(canvas, point);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
