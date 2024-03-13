import 'dart:math' as math;
import 'dart:ui';

const pi = 3.141592653589793238;

double degreeToRadian(double degree) {
  return degree * pi / 180;
}

double radianToDegree(double radian) {
  return radian * 180 / pi;
}

double cosDegree(double degree) {
  return math.cos(degreeToRadian(degree));
}

double sinDegree(double degree) {
  return math.sin(degreeToRadian(degree));
}

double distanseToLine(Offset point, Offset p1, Offset p2) {
  var a = lineFunction(p1, p2).$1;
  var b = lineFunction(p1, p2).$2;
  var c = lineFunction(p1, p2).$3;

  var dist = (a * point.dx + b * point.dy + c).abs() /
      math.sqrt(math.pow(a, 2) + math.pow(b, 2));
  if (distanseBetweenPoints(p1, p2) / 2 >
      distanseBetweenPoints(point, (p1 + p2) / 2)) return dist;
  return dist * 100;
}

(double, double, double) lineFunction(Offset p1, Offset p2) {
  return (p1.dy - p2.dy, p2.dx - p1.dx, p1.dx * p2.dy - p2.dx * p1.dy);
}

double distanseBetweenPoints(Offset p1, Offset p2) {
  return math.sqrt(math.pow(p2.dx - p1.dx, 2) + math.pow(p2.dy - p1.dy, 2));
}
