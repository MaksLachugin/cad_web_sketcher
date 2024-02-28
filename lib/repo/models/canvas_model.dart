// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';
import 'dart:ui';

import 'package:cad_web_sketcher/repo/models/base_element_enum.dart';
import 'package:cad_web_sketcher/repo/models/figure.dart';
import 'package:cad_web_sketcher/repo/utils/custom_math.dart';

class CanvasModel {
  Offset pozCamera = const Offset(0, 0);
  Size sizeOfScreen = const Size(700, 700);
  double angle = 35;

  Figure figure;
  CanvasModel({
    required this.figure,
  });
  List<Offset> getPointsToDraw(Size size) {
    List<Offset> points = figure.pointsToDraw;
    points = rotateFigure(points, size);
    points = scaleToScreen(points, size);
    points = goToCenterOfScreen(points, size);
    return points;
  }

  List<Offset> rotateFigure(List<Offset> points, Size size) {
    Offset center =
        Offset(size.width / 2 + pozCamera.dx, size.height / 2 + pozCamera.dy);
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

  CanvasModel.fromRoofElement(RoofElements element) : figure = Figure() {
    switch (element) {
      case RoofElements.abutment:
        figure.addLine(0, 100);
        figure.addLine(-90, 150);
        figure.bending = [true, true];
      case RoofElements.drip:
        figure.addLine(0, 60);
        figure.addLine(135, 40);
        figure.bending = [false, true];
      case RoofElements.simpleRidge:
        figure.addLine(0, 150);
        figure.addLine(90, 150);
        figure.bending = [true, true];
      case RoofElements.snowStop:
        figure.addLine(0, 30);
        figure.addLine(-110, 90);
        figure.addLine(55, 110);
        figure.addLine(-125, 30);
        figure.bending = [true, true];
      case RoofElements.valleyBottom:
        figure.addLine(0, 150);
        figure.addLine(125, 30);
        figure.addLine(90, 40);
        figure.addLine(-90, 30);
        figure.addLine(125, 150);
        figure.bending = [true, true];
      case RoofElements.curvedRidge:
        figure.addLine(0, 150);
        figure.addLine(-135, 30);
        figure.addLine(90, 40);
        figure.addLine(90, 30);
        figure.addLine(-135, 150);
        figure.bending = [true, true];
      case RoofElements.endStripsForMetalRoofTiles:
        figure.addLine(0, 20);
        figure.addLine(120, 90);
        figure.addLine(90, 85);
        figure.addLine(-135, 20);
        figure.bending = [true, true];
      case RoofElements.valleyTop:
        figure.addLine(0, 145);
        figure.addLine(-110, 150);
        figure.bending = [true, true];
      case RoofElements.frontalLStrip:
        figure.addLine(0, 100);
        figure.addLine(-90, 20);
        figure.bending = [false, true];
      case RoofElements.endCapForSoftFoofs:
        figure.addLine(0, 60);
        figure.addLine(-135, 25);
        figure.addLine(45, 80);
        figure.bending = [false, true];
    }
  }

  CanvasModel.empty() : figure = Figure();

  Offset getCenterOfFigure(List<Offset> points) {
    double minx = 0;
    double miny = 0;
    double maxx = 0;
    double maxy = 0;
    points.forEach((element) {
      minx = (minx > element.dx) ? element.dx : minx;
      miny = (miny > element.dy) ? element.dy : miny;

      maxx = (maxx < element.dx) ? element.dx : maxx;
      maxy = (maxy < element.dy) ? element.dy : maxy;
    });
    return Offset((maxx + minx) / 2, (maxy + miny) / 2);
  }

  List<Offset> scaleToScreen(List<Offset> points, Size size) {
    var center = getCenterOfFigure(points);
    points = points.map((e) => e -= center).toList();
    double minx = 0;
    double miny = 0;
    double maxx = 0;
    double maxy = 0;
    points.forEach((element) {
      minx = (minx > element.dx) ? element.dx : minx;
      miny = (miny > element.dy) ? element.dy : miny;

      maxx = (maxx < element.dx) ? element.dx : maxx;
      maxy = (maxy < element.dy) ? element.dy : maxy;
    });
    double scalex = (size.width - 50) / (maxx - minx);
    double scaley = (size.height - 50) / (maxy - miny);
    double minscale = min(scaley, scalex);
    points = points.map((e) {
      return e * minscale;
    }).toList();

    return points;
  }

  List<Offset> goToCenterOfScreen(List<Offset> points, Size size) {
    var newCenter = getCenterOfScreen(size) - getCenterOfFigure(points);
    points = points.map((e) => e += newCenter).toList();
    return points;
  }

  Offset getCenterOfScreen(Size size) {
    Size center = size / 2;
    return Offset(center.width, center.height);
  }

  List<(Offset, String)> angelTextPointsToDraw(List<Offset> points, Size size) {
    List<String> angles = figure.listAngle();
    return List.generate(
        angles.length, (index) => (points[index], angles[index]));
  }

  List<(Offset, String)> lenTextPointsToDraw(List<Offset> points, Size size) {
    List<String> angles = figure.listLen();
    return List.generate(
        angles.length,
        (index) =>
            ((points[index] + points[index + 1]) / 2, "${angles[index]}мм"));
  }
}
