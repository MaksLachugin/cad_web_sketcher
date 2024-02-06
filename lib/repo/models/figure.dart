import 'dart:ui';

import 'line.dart';

class Figure {
  List<Line> lines = <Line>[];
  Offset startPoint;

  Figure([this.startPoint = const Offset(50, 50)]);

  get length => lines.length;

  int addLine(double angle, int len) {
    if (lines.isEmpty) {
      lines.add(Line(startPoint, len, angle));
      return 1;
    }
    lines.add(Line(lines.last.endPoint!, len, angle));
    return 1;
  }

  int addLineDefault() {
    return addLine(90, 100);
  }

  List<Offset> listToDraw() {
    List<Offset> res = <Offset>[];

    res.add(startPoint);

    for (var element in lines) {
      res.add(element.endPoint!);
    }

    return res;
  }
}

Figure genFig() {
  Figure figure = Figure(const Offset(0, 0));
  figure.addLine(0, 500);
  figure.addLine(90, 500);
  figure.addLine(180, 600);
  figure.addLine(-90, 500);
  return figure;
}
