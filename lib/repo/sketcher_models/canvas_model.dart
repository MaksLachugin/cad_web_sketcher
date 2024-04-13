// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';
import 'dart:ui';
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:cad_web_sketcher/repo/utils/custom_math.dart';

class CanvasModel {
  Offset pozCamera = const Offset(0, 0);
  Size sizeOfScreen = const Size(700, 700);
  double angle = 0;
  Figure figure;
  CanvasModel({
    required this.figure,
  });

  void changeLine(int index, Line line) {
    figure.lines[index] = line;
  }

  void insertNewLine(
    int index,
  ) {
    figure.lines.insert(index, Line(50, 180));
  }

  CanvasModel.fromEnum(Enum element) : figure = Figure() {
    switch (element.runtimeType) {
      case const (RoofElements):
        switch (element) {
          case RoofElements.abutment:
            angle = 90;
            figure.addLine(0, 100);
            figure.addLine(-90, 150);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.drip:
            angle = 180;
            figure.addLine(0, 60);
            figure.addLine(135, 40);
            figure.bending = [Bending.absent, Bending.inside];
          case RoofElements.simpleRidge:
            angle = -45;
            figure.addLine(0, 150);
            figure.addLine(90, 150);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.snowStop:
            angle = 0;
            figure.addLine(0, 30);
            figure.addLine(-110, 90);
            figure.addLine(55, 110);
            figure.addLine(-125, 30);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.valleyBottom:
            angle = 35;
            figure.addLine(0, 150);
            figure.addLine(125, 30);
            figure.addLine(-90, 40);
            figure.addLine(-90, 30);
            figure.addLine(125, 150);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.curvedRidge:
            angle = -45;
            figure.addLine(0, 150);
            figure.addLine(-135, 30);
            figure.addLine(90, 40);
            figure.addLine(90, 30);
            figure.addLine(-135, 150);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.endStripsForMetalRoofTiles:
            angle = -60;
            figure.addLine(0, 20);
            figure.addLine(120, 90);
            figure.addLine(90, 85);
            figure.addLine(-135, 20);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.valleyTop:
            angle = 35;
            figure.addLine(0, 145);
            figure.addLine(-110, 150);
            figure.bending = [Bending.inside, Bending.inside];
          case RoofElements.frontalLStrip:
            angle = -90;
            figure.addLine(0, 100);
            figure.addLine(-90, 20);
            figure.bending = [Bending.absent, Bending.outside];
          case RoofElements.endCapForSoftFoofs:
            angle = 180;
            figure.addLine(0, 60);
            figure.addLine(-135, 25);
            figure.addLine(45, 80);
            figure.bending = [Bending.absent, Bending.inside];
        }
        break;
      case const (Parapets):
        switch (element) {
          case Parapets.flat:
            angle = -45;
            figure.addLine(0, 20);
            figure.addLine(-135, 40);
            figure.addLine(90, 150);
            figure.addLine(90, 40);
            figure.addLine(-135, 20);
            figure.bending = [Bending.inside, Bending.inside];

          case Parapets.shaped:
            angle = -45;
            figure.addLine(0, 20);
            figure.addLine(-135, 40);
            figure.addLine(120, 100);
            figure.addLine(120, 100);
            figure.addLine(120, 40);
            figure.addLine(-135, 20);
            figure.bending = [Bending.inside, Bending.inside];
          default:
        }
      default:
        angle = -90;
        figure.addLine(0, 100);

        figure.bending = [Bending.inside, Bending.inside];
    }
  }

  List<Offset> getPointsToDraw(Size size, double scale) {
    List<Offset> points = figure.pointsToDraw
        .map((e) => Offset(e.dx, size.width - e.dy))
        .toList();

    points = rotateFigure(points, size);
    points = goToCenterOfScreen(points, size);
    return points;
  }

  int indexOfNearLine(Offset point, Size size, int before) {
    List<Offset> points = ignoreBendingLine(getPointsToDraw(size, 0.8));
    int index = before;
    double minDist = double.infinity;
    for (var i = 0; i < points.length - 1; i++) {
      var dist = distanseToLine(point, points[i], points[i + 1]);
      if (dist < minDist) {
        minDist = dist;
        index = i;
      }
    }

    if (minDist > 10) return before;
    return index;
  }

  List<Offset> rotateFigure(List<Offset> points, Size size) {
    Offset center = getCenterOfScreen(size);
    double s = sinDegree(angle);
    double c = cosDegree(angle);

    points = points.map((e) {
      e -= center;
      e = Offset(e.dx * c - e.dy * s, e.dx * s + e.dy * c);
      e += center;
      return e;
    }).toList();
    return points;
  }

  CanvasModel.empty() : figure = Figure();

  Offset getCenterOfFigure(List<Offset> points) {
    var clearPoints = ignoreBendingLine(points);
    return clearPoints.reduce((a, b) => a + b) / (clearPoints.length as double);
  }

  List<Offset> scaleToScreen(List<Offset> points, Size size, double scale) {
    var center = getCenterOfFigure(points);
    points = points.map((e) => e -= center).toList();
    double minx = 0;
    double miny = 0;
    double maxx = 0;
    double maxy = 0;
    for (var element in points) {
      minx = (minx > element.dx) ? element.dx : minx;
      miny = (miny > element.dy) ? element.dy : miny;

      maxx = (maxx < element.dx) ? element.dx : maxx;
      maxy = (maxy < element.dy) ? element.dy : maxy;
    }
    double scalex = (size.width) / (maxx - minx);
    double scaley = (size.height) / (maxy - miny);
    double minscale = min(scaley, scalex);
    points = points.map((e) {
      return e * (minscale * scale);
    }).toList();

    return points;
  }

  List<Offset> goToCenterOfScreen(List<Offset> points, Size size) {
    var newCenter = getCenterOfScreen(size) - getCenterOfFigure(points);
    points = points.map((e) => e += newCenter).toList();
    while (points.any((element) => size.contains(element))) {
      newCenter = getCenterOfFigure(points);
      points = points.map((e) {
        e -= newCenter;
        e *= 1.1;
        e += newCenter;
        return e;
      }).toList();
    }
    while (points.any((element) => !size.contains(element))) {
      newCenter = getCenterOfFigure(points);
      points = points.map((e) {
        e -= newCenter;
        e *= 0.9;
        e += newCenter;
        return e;
      }).toList();
    }

    return points;
  }

  Offset getCenterOfScreen(Size size) {
    return size.center(Offset.zero);
  }

  List<(Offset, String)> angelTextPointsToDraw(List<Offset> points, Size size) {
    points = ignoreBendingLine(points);
    List<String> angles = figure.listAngle();
    return List.generate(angles.length - 1,
        (index) => (points[index + 1], "${angles[index + 1]}°"));
  }

  List<(Offset, String)> lenTextPointsToDraw(List<Offset> points, Size size) {
    points = ignoreBendingLine(points);

    List<String> angles = figure.listLen();
    return List.generate(
        angles.length,
        (index) =>
            ((points[index] + points[index + 1]) / 2, "${angles[index]}мм"));
  }

  int getTrueIndex(int selectedLine) {
    if (figure.bending[0] == Bending.absent) {
      return selectedLine;
    }
    return selectedLine + 2;
  }

  List<Offset> ignoreBendingLine(List<Offset> pointsToDraw) {
    List<Offset> res = List.from(pointsToDraw);
    if (figure.bending[0] != Bending.absent) {
      res.removeAt(0);
      res.removeAt(0);
    }
    if (figure.bending[1] != Bending.absent) {
      res.removeAt(res.length - 1);
      res.removeAt(res.length - 1);
    }

    return res;
  }

  void setStartBending(Bending bending) {
    if (bending == Bending.absent || figure.bending[0] == Bending.absent) {
      angle += 180;
    }
    figure.bending[0] = bending;
  }

  void setEndBending(Bending bending) {
    figure.bending[1] = bending;
  }

  Bending getStartBending() {
    return figure.bending[0];
  }

  Bending getEndBending() {
    return figure.bending[1];
  }
}
