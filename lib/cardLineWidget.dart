import 'dart:html';
import 'dart:ui';

import 'package:cad_web_sketcher/base/line.dart';
import 'package:flutter/material.dart';

Widget cardItemWidget(Line line) {
  return SizedBox(
    child: Card(
      child: Column(
        children: [
          pointWidget("Начальная точка", line.point),
          textAndFormField("Длина", line.len),
          textAndFormField("Угол", line.angle),
          pointWidget("Конечная точка", line.getEndPoint()),
        ],
      ),
    ),
  );
}

Widget textAndFormField(String nameParam, num value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        nameParam,
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        width: 100,
        height: 100,
        child: TextFormField(
          initialValue: "${value}",
        ),
      ),
    ],
  );
}

Widget pointWidget(String nameOfPoint, Offset point) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        nameOfPoint,
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        width: 100,
        height: 100,
        child: TextFormField(
          initialValue: "${point.dx}",
        ),
      ),
      SizedBox(
        width: 100,
        height: 100,
        child: TextFormField(
          initialValue: "${point.dy}",
        ),
      ),
    ],
  );
}
