import 'dart:ui';

import 'package:cad_web_sketcher/repo/utils/customMath.dart';
import 'package:equatable/equatable.dart';
import 'line.dart';

class Figure extends Equatable {
  List<Line> lines = <Line>[];
  Offset startPoint;

  Figure([this.startPoint = const Offset(50, 50)]);

  get length => lines.length;

  void addLine(double angle, int len) {
    lines.add(Line(len, angle));
  }

  void changeLine(int index, double angle, int len) {
    if (lines.isEmpty) {
      return;
    }
    if (index >= 0 && index < length) {
      lines[index].angle = angle;
      lines[index].len = len;
    }
  }

  void addLineDefault() {
    return addLine(90, 50);
  }

  List<Offset> listToDraw() {
    List<Offset> res = <Offset>[];
    Offset first = startPoint;
    res.add(first);
    for (var line in lines) {
      first = genEndPoint(first, line);
      res.add(first);
    }
    return res;
  }

  @override
  List<Object?> get props => [startPoint, lines];
  //TODO add inserts
}

Offset genEndPoint(Offset point, Line line) {
  return Offset(point.dx + line.len * cosDegree(line.angle + 180),
      point.dy + line.len * sinDegree(line.angle));
}

Figure genFig() {
  Figure figure = Figure(const Offset(150, 150));
  figure.addLine(0, 500);
  figure.addLine(90, 500);
  figure.addLine(180, 600);
  figure.addLine(-90, 500);
  return figure;
}
