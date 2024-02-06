import 'dart:ui';
import 'package:cad_web_sketcher/repo/utils/customMath.dart';

class Line {
  Offset _point;

  Offset get point => _point;

  set point(Offset value) {
    _point = value;
  }

  int _len;

  int get len => _len;

  set len(int value) {
    _len = value;
  }

  double _angle;

  double get angle => _angle;

  set angle(double value) {
    _angle = value;
  }

  Offset? _endPoint;

  Offset? get endPoint {
    genEndPoint();
    return _endPoint;
  }

  set endPoint(Offset? value) {
    _endPoint = value;
  }

  Line(this._point, this._len, this._angle);

  void genEndPoint() {
    endPoint = Offset(
        point.dx + len * cosDegree(angle), point.dy + len * sinDegree(angle));
  }
}
