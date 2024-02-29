// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:cad_web_sketcher/repo/models/figure.dart';

class LineTile extends StatelessWidget {
  LineTile({
    super.key,
    required this.figure,
    required this.index,
  }) {
    var line = figure.lines[index];

    controller1 = TextEditingController(text: line.angle.toString());
    controller2 = TextEditingController(text: line.len.toString());
  }

  final Figure figure;
  final int index;
  late TextEditingController controller1;
  late TextEditingController controller2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      figure.addLineDefault();
                    },
                    icon: const Icon(Icons.add)),
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                          height: 50, child: Center(child: Text('Угол'))),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller1,
                          onChanged: (value) => changeAngle(value),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                          width: 50, child: Center(child: Text('Длина'))),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller2,
                          onChanged: (value) => changeLen(value),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      figure.addLineDefault();
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeAngle(String angle) {
    changeLine(angle, controller2.text);
  }

  void changeLen(String len) {
    changeLine(controller1.text, len);
  }

  void changeLine(String angle, String len) {
    if (angle.isNotEmpty && len.isNotEmpty) {
      // figure.changeLine(index, double.parse(angle), double.parse(len));
      print("Что-то изменилось");
    }
  }
}
