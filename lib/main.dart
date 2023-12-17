import 'package:cad_web_sketcher/base/figure.dart';
import 'package:flutter/material.dart';

import 'base/line.dart';
import 'canvasWidget.dart';
import 'cardLineWidget.dart';

void main() {
  runApp(MyApp());
}

final Figure figure = genFig();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: mainWidget());
  }
}

Widget mainWidget() {
  return SingleChildScrollView(
    child: Column(
      children: [
        canvasWidget(),
        sendButtonWidget(),
        cardItemWidget(Line(Offset(50, 100), 100, 45)),
      ],
    ),
  );
}



Widget sendButtonWidget() {
  return TextButton(
    onPressed: () {
      figure.lines[1].len += 50;
    },
    child: Container(
      color: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: const Text(
        'Flat Button',
        style: TextStyle(color: Colors.white, fontSize: 13.0),
      ),
    ),
  );
}

Widget canvasWidget() {
  return SizedBox(
    width: 800.0,
    height: 800.0,
    child: Card(
      color: Colors.green,
      child: MyCanvasWidget(),
    ),
  );
}

Figure genFig() {
  Figure figure = Figure(Offset(0, 0));
  figure.addLine(0, 500);
  figure.addLine(90, 500);
  figure.addLine(180, 600);
  figure.addLine(-90, 500);
  return figure;
}
