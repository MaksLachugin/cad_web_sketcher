import 'dart:math';

double PI = 3.141592653589793238;

double degreeToRadian(double degree) {
  return degree * PI / 180;
}

double radianToDegree(double radian) {
  return radian * 180 / PI;
}

double cosDegree(double degree) {
  return cos(degreeToRadian(degree));
}

double sinDegree(double degree) {
  return sin(degreeToRadian(degree));
}