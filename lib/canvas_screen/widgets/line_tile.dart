// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LineTile extends StatefulWidget {
  LineTile({
    super.key,
    required this.index,
    required this.line,
    required this.changeLineCall,
    required this.insertNewLine,
  })  : controller1 = TextEditingController(text: line.angle.toString()),
        controller2 = TextEditingController(text: line.len.toString());
  final int index;
  final Line line;
  final Function(int index, Line newLine) changeLineCall;
  final Function(int index) insertNewLine;

  final TextEditingController controller1;
  final TextEditingController controller2;

  @override
  State<LineTile> createState() => _LineTileState();
}

class _LineTileState extends State<LineTile> {
  final RegExp expAngle = RegExp(r"^(?:-?(?:1[0-7][0-9]|[1-9]?[0-9]|180))$");

  final RegExp expLen = RegExp(r"\b(0|[1-9]\d*)\b");
  late double len;
  late double angle;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    len = widget.line.len;
    angle = widget.line.angle;

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
                      widget.insertNewLine(widget.index);
                    },
                    icon: const Icon(Icons.add)),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration:
                                    const InputDecoration(labelText: "Угол"),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Укажите угол';
                                  }
                                  var v = int.parse(value);
                                  if (v > 179 || v < -179) {
                                    return 'Диапозоне от -179 до 179';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9]"),
                                  )
                                ],
                                initialValue: angle.toString(),
                                onSaved: (newValue) {
                                  angle = double.parse(newValue!);
                                }),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Длина"),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null) {
                                  return 'Укажите длину';
                                }
                                var v = int.parse(value);
                                if (v < 1) {
                                  return 'Длина должна быть больше 0';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"),
                                )
                              ],
                              initialValue: len.toString(),
                              onSaved: (newValue) {
                                len = double.parse(newValue!);
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState!.save();
                              changeLine(angle, len);
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 50,
                          ))
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.insertNewLine(widget.index + 1);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeLine(double angle, double len) {
    var newLine = widget.line.copyWith(angle: angle, len: len);

    widget.changeLineCall(widget.index, newLine);

    GetIt.I<Talker>().debug("Что-то изменилось");
  }
}
