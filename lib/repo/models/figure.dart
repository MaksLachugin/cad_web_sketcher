import 'dart:ui';

import 'package:cad_web_sketcher/repo/models/bending_enum.dart';
import 'package:cad_web_sketcher/repo/utils/custom_math.dart';
import 'package:equatable/equatable.dart';
import 'line.dart';

class Figure extends Equatable {
  var bending = List<Bending>.filled(2, Bending.inside);

  List<Line> bendingLine = List.filled(2, Line(15, 0));
  List<Line> lines = <Line>[];
  List<Offset> get pointsToDraw {
    return listLinesToDraw();
  }

  Offset startPoint;

  Figure([this.startPoint = const Offset(0.0, 0.0)]);

  get length => lines.length;

  void addLine(double angle, double len) {
    lines.add(Line(len, angle));
  }

  void addLineDefault() {
    return addLine(90, 50);
  }

  List<Offset> listLinesToDraw() {
    double ang = 0;
    List<Offset> res = <Offset>[];
    Offset first = startPoint;
    res.add(first);
    for (var line in linesWithBending()) {
      (first, ang) = getEndPoint(ang, line, first);

      res.add(first);
    }
    return res;
  }

  (Offset, double) getEndPoint(double ang, Line line, Offset first) {
    ang = ang - ((line.angle > 0) ? (180 - line.angle) : -(180 + line.angle));
    first = Offset.fromDirection(degreeToRadian(ang), line.len) + first;
    return (first, ang);
  }

  List<String> listLen() {
    List<String> res = <String>[];

    for (var line in lines) {
      res.add((line.len.toString()));
    }

    return res;
  }

  List<String> listAngle() {
    List<String> res = <String>[];

    for (var line in lines) {
      res.add(line.angle.toString());
    }
    return res;
  }

  List<Line> linesWithBending() {
    List<Line> lst = [];
    lst.addAll(lines);

    switch (bending[0]) {
      case Bending.absent:
        break;
      case Bending.outside:
        lst.insertAll(0, [
          Line(15, 0),
          Line(2.5, -90),
        ]);
        lst[2] = lst[2].copyWith(angle: -90);

      case Bending.inside:
        lst.insertAll(0, [
          Line(15, 0),
          Line(2.5, 90),
        ]);
        lst[2] = lst[2].copyWith(angle: 90);
    }

    switch (bending[1]) {
      case Bending.absent:
        break;

      case Bending.outside:
        lst.addAll([
          Line(2.5, -90),
          Line(15, -90),
        ]);

      case Bending.inside:
        lst.addAll([
          Line(2.5, 90),
          Line(15, 90),
        ]);
    }

    return lst;
  }

  @override
  List<Object?> get props => [startPoint, lines];
}
