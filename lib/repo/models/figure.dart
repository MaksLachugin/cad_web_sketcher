import 'dart:ui';

import 'package:cad_web_sketcher/repo/utils/custom_math.dart';
import 'package:equatable/equatable.dart';
import 'line.dart';

class Figure extends Equatable {
  List<bool> _bending = List.filled(2, false);

  List<bool> get bending => _bending;

  set bending(List<bool> value) {
    if (value.length == 2) {
      _bending = value;
    } else {
      throw Exception("На листе может быть только 2 загиба");
    }
  }

  List<Line> bendingLine = List.filled(2, const Line(15, 0));
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
    for (var line in lines) {
      first = genEndPoint(first, line, ang);
      ang = ang + line.angle;
      res.add(first);
    }
    return res;
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

  @override
  List<Object?> get props => [startPoint, lines];
}

Offset genEndPoint(Offset point, Line line, double nowAngle) {
  double ang;
  line = line.copyWith(angle: line.angle % -180);
  if (line.angle % 180 == 0) {
    ang = line.angle + nowAngle;
  } else if (line.angle >= 0 && nowAngle >= 0) {
    ang = (-180 + (line.angle) + nowAngle);
  } else if (line.angle >= 0 && nowAngle <= 0) {
    ang = line.angle + nowAngle;
  } else if (line.angle < 0 && nowAngle >= 0) {
    ang = -180 + line.angle - nowAngle;
  } else if (line.angle < 0 && nowAngle <= 0) {
    ang = (180 + line.angle) - nowAngle;
  } else {
    ang = line.angle;
  }
  print('line = ${line.angle} now= $nowAngle itog= $ang');
  return Offset.fromDirection(degreeToRadian(ang), line.len) + point;
  // return Offset(point.dx + line.len * cosDegree(ang),
  //     point.dy + line.len * sinDegree(ang));
}

Figure genFig() {
  Figure figure = Figure(const Offset(150, 150));
  figure.addLine(0, 500);
  figure.addLine(90, 500);
  figure.addLine(180, 600);
  figure.addLine(-90, 500);
  return figure;
}
