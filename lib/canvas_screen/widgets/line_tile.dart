// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LineTile extends StatelessWidget {
  LineTile({
    super.key,
    required this.index,
    required this.line,
    required this.changeLineCall,
    this.insertNewLine,
  })  : controller1 = TextEditingController(text: line.angle.toString()),
        controller2 = TextEditingController(text: line.len.toString());
  final int index;
  final Line line;
  final Function(int index, Line newLine) changeLineCall;
  final Function(int index)? insertNewLine;

  final TextEditingController controller1;
  final TextEditingController controller2;
  final RegExp expAngle = RegExp(r"^(?:-?(?:1[0-7][0-9]|[1-9]?[0-9]|180))$");
  final RegExp expLen = RegExp(r"\b(0|[1-9]\d*)\b");

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
                (insertNewLine != null)
                    ? IconButton(
                        onPressed: () {
                          insertNewLine!(index);
                        },
                        icon: const Icon(Icons.add))
                    : Container(),
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
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.deny(expAngle),
                          // ],
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
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.deny(expLen),
                          // ],
                          controller: controller2,
                          onChanged: (value) => changeLen(value),
                        ),
                      ),
                    ],
                  ),
                ),
                (insertNewLine != null)
                    ? IconButton(
                        onPressed: () {
                          insertNewLine!(index + 1);
                        },
                        icon: const Icon(Icons.add),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeAngle(String angle) {
    if (expAngle.hasMatch(angle)) {
      changeLineCall(index, line.copyWith(angle: double.parse(angle)));
    } else {}
  }

  void changeLen(String len) {
    if (expLen.hasMatch(len)) {
      changeLine(controller1.text, len);
    } else {}
  }

  void changeLine(String angle, String len) {
    if (expAngle.hasMatch(angle) && expLen.hasMatch(len)) {
      var newLine =
          line.copyWith(angle: double.parse(angle), len: double.parse(len));

      changeLineCall(index, newLine);
      GetIt.I<Talker>().debug("Что-то изменилось");
    }
  }
}
