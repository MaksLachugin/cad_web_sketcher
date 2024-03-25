import 'dart:ui';

import 'package:cad_web_sketcher/repo/models/canvas_model.dart';
import 'package:flutter/material.dart';

class CanvasWidget extends StatelessWidget {
  final int selected;
  final CanvasModel canvasModel;

  const CanvasWidget(
      {super.key, required this.selected, required this.canvasModel});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(canvasModel, selected),
    );
  }
}

class MyPainter extends CustomPainter {
  final int selected;
  final CanvasModel canvasModel;
  Paint get linePainter {
    Paint painter = Paint()..color = Colors.grey.shade700;
    painter.strokeWidth = 2;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  Paint get selectedLinePainter {
    Paint painter = Paint()..color = Colors.green;
    painter.strokeWidth = 3;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  Paint get pointPainter {
    Paint painter = Paint()..color = Colors.red;
    painter.strokeWidth = 1;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  Paint get colorPainter {
    Paint painter = Paint()..color = Colors.blue;
    painter.strokeWidth = 5;
    painter.strokeCap = StrokeCap.round;
    return painter;
  }

  MyPainter(this.canvasModel, this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> pointsToDraw = canvasModel.getPointsToDraw(size, 0.8);

    if (selected != -1) {
      canvas.drawPoints(
          PointMode.polygon,
          [
            pointsToDraw[canvasModel.getTrueIndex(selected)],
            pointsToDraw[canvasModel.getTrueIndex(selected) + 1]
          ],
          selectedLinePainter);
    }
    drawFigure(canvas, pointsToDraw);

    drawListPointAndText(
        size, canvas, canvasModel.angelTextPointsToDraw(pointsToDraw, size));
    drawListPointAndText(
        size, canvas, canvasModel.lenTextPointsToDraw(pointsToDraw, size));
  }

  void drawCanvasModel(CanvasModel cm) {}

  void drawFigure(Canvas canvas, List<Offset> points) {
    canvas.drawPoints(PointMode.polygon, points, linePainter);
    canvas.drawPoints(PointMode.points, points, pointPainter);
    canvas.drawPoints(PointMode.points, [canvasModel.getCenterOfFigure(points)],
        colorPainter);
  }

  void drawBending(Canvas canvas, List<Offset> element) {
    canvas.drawPoints(PointMode.polygon, element, linePainter);
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
