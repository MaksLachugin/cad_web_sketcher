import 'dart:ui';

import 'package:cad_web_sketcher/base/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget cardItemWidget(Line line) {
  return SizedBox(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            pointWidget("Начальная точка", line.point, true),
            Row(
              children: [
                textAndFormField("Длина", line.len),
                SizedBox(width: 50),
                textAndFormField("Угол", line.angle),
              ],
            ),
            pointWidget("Конечная точка", line.getEndPoint(), false),
          ],
        ),
      ),
    ),
  );
}

Widget textAndFormField(String nameParam, num value) {
  return Container(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      width: 100,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(labelText: nameParam),
        initialValue: "${value}",
      ),
    ),
  );
}

Widget pointWidget(String nameOfPoint, Offset point, bool canChange) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 100,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          enabled: canChange,
          decoration: InputDecoration(labelText: "X"),
          initialValue: "${point.dx}",
        ),
      ),
      SizedBox(width: 50),
      SizedBox(
        width: 100,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          enabled: canChange,
          decoration: InputDecoration(labelText: "Y"),
          initialValue: "${point.dy}",
        ),
      ),
    ],
  );
}
