import 'package:cad_web_sketcher/canvas_screen/widgets/canvasWidget.dart';
import 'package:flutter/material.dart';

class CanvasScreen extends StatelessWidget {
  const CanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: SizedBox(
                height: 700,
                width: 700,
                child: Card(
                  color: Colors.green,
                  child: MyCanvasWidget(),
                ),
              ),
            ),
            sendButtonWidget(),
          ],
        ),
      ),
    );
  }
}

Widget sendButtonWidget() {
  return TextButton(
    onPressed: () {
      // figure.lines[1].len += 50;
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: const Text('Flat Button'),
    ),
  );
}
