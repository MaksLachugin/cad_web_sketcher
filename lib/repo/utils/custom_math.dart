import 'dart:math';

const pi = 3.141592653589793238;

double degreeToRadian(double degree) {
  return degree * pi / 180;
}

double radianToDegree(double radian) {
  return radian * 180 / pi;
}

double cosDegree(double degree) {
  return cos(degreeToRadian(degree));
}

double sinDegree(double degree) {
  return sin(degreeToRadian(degree));
}
