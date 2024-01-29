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

  List<Offset> listToDraw() {
    List<Offset> res = <Offset>[];

    res.add(startPoint);

    for (var element in lines) {
      res.add(element.endPoint!);
    }

    return res;
  }
}
