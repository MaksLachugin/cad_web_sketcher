import 'dart:math';
import 'dart:ui';

import 'package:cad_web_sketcher/base/customMath.dart';

class Line {
  Offset point;
  int len;
  double angle;
  Offset? endPoint;

  Line(this.point, this.len, this.angle);

  Offset getEndPoint(){
    if (endPoint != null) {
      return endPoint!;
    }
    int mod = 1; // Если угол отрацательный то мы инвертируем позицию Y
    if (angle < 0) {
      mod = -1;
    }
    endPoint = Offset(point.dx + len * cosDegree(angle), point.dy + mod * len * sinDegree(angle));
    return getEndPoint();
  }
}
