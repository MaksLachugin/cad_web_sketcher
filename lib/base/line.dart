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

    endPoint = Offset(point.dx + len * cosDegree(angle), point.dy +  len * sinDegree(angle));
    return getEndPoint();
  }
}
