// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';
import 'dart:ui';

import 'package:cad_web_sketcher/repo/models/base_element_enum.dart';
import 'package:cad_web_sketcher/repo/models/figure.dart';
import 'package:cad_web_sketcher/repo/utils/custom_math.dart';

class CanvasModel {
  Offset pozCamera = const Offset(0, 0);
  Size sizeOfScreen = const Size(700, 700);
  double angle = 0;

  Figure figure;
  CanvasModel({
    required this.figure,
  });
  List<Offset> getPointsToDraw(Size size, double scale) {
    List<Offset> points = figure.pointsToDraw
        .map((e) => Offset(e.dx, size.width - e.dy))
        .toList();

    points = rotateFigure(points, size);
    // points = scaleToScreen(points, size, scale);
    points = goToCenterOfScreen(points, size);
    // print(angle);
    return points;
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

  CanvasModel.fromRoofElement(RoofElements element) : figure = Figure() {
    switch (element) {
      case RoofElements.abutment:
        angle = 90;
        figure.addLine(0, 100);
        figure.addLine(-90, 150);
        figure.bending = [true, true];
      case RoofElements.drip:
        angle = 0;
        figure.addLine(0, 60);
        figure.addLine(135, 40);
        figure.bending = [false, true];
      case RoofElements.simpleRidge:
        angle = -45;
        figure.addLine(0, 150);
        figure.addLine(90, 150);
        figure.bending = [true, true];
      case RoofElements.snowStop:
        angle = 0;
        figure.addLine(0, 30);
        figure.addLine(-110, 90);
        figure.addLine(55, 110);
        figure.addLine(-125, 30);
        figure.bending = [true, true];
      case RoofElements.valleyBottom:
        angle = 0;
        figure.addLine(125, 90);
        figure.addLine(90, 90);
        // figure.addLine(-90, 90);
        // figure.addLine(-90, 90);
        // figure.addLine(-45, 90);
        // figure.addLine(-45, 90);
        // figure.addLine(-45, 90);
        // figure.addLine(0, 90);
        // figure.addLine(45, 90);
        // figure.addLine(45, 90);
        // figure.addLine(45, 90);
        // figure.addLine(45, 90);

        // figure.addLine(0, 150);
        // figure.addLine(125, 30);
        // figure.addLine(-90, 40);
        // figure.addLine(-90, 30);
        // figure.addLine(125, 150);
        figure.bending = [true, true];
      case RoofElements.curvedRidge:
        angle = -135;
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
    return points.reduce((a, b) => a + b) / (points.length as double);
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

    // center = getCenterOfScreen(size);
    // Offset maxDistOffset = Offset.zero;
    // points.forEach((element) {
    //   var dist = center - element;
    //   if (dist.distance > maxDistOffset.distance) {
    //     maxDistOffset = dist;
    //   }
    // });

    // var scaleIfPointOutOfScreen = center.distance / maxDistOffset.distance;
    // print(scaleIfPointOutOfScreen);
    // if (scaleIfPointOutOfScreen < 1) {
    //   points = points.map((e) {
    //     return e * (scaleIfPointOutOfScreen);
    //   }).toList();
    // }

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
    // double maxOutTop = 0;
    // double maxOutLeft = 0;
    // double maxOutRight = 0;
    // double maxOutBottom = 0;
    // points.forEach((element) {
    //   if (element.dx > size.width) {
    //     maxOutRight = element.dx -size.width;
    //   } else if (element.dy > size.height) {
    //     maxOutBottom = element.dy-size.height;
    //   } else if (element.dx < 0) {
    //     maxOutLeft = element.dx;
    //   } else if (element.dy < 0) {
    //     maxOutTop = element.dy;
    //   }
    // });

    // points = points.map((e) {
    //   if
    //   return ;
    // })
    return points;
  }

  Offset getCenterOfScreen(Size size) {
    return size.center(Offset.zero);
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
