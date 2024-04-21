// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LineTile extends StatefulWidget {
  const LineTile({
    super.key,
    required this.index,
    required this.line,
    required this.changeLineCall,
    required this.insertNewLine,
  });
  final int index;
  final Line line;
  final Function(int index, Line newLine) changeLineCall;
  final Function(int index) insertNewLine;

  @override
  State<LineTile> createState() => _LineTileState();
}

class _LineTileState extends State<LineTile> {
  double len = 0;
  double angle = 0;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    len = widget.line.len;
    angle = widget.line.angle;
    _formKey = GlobalKey<FormState>();
  }

  @override
  didUpdateWidget(LineTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _formKey = GlobalKey<FormState>();
      len = widget.line.len;
      angle = widget.line.angle;
    }
  }

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        widget.insertNewLine(widget.index);
                      },
                      icon: const Icon(Icons.add)),
                ),
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
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
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState!.save();
                            changeLine(angle, len);
                          }
                        },
                        child: const Text("Изменить"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      widget.insertNewLine(widget.index + 1);
                    },
                    icon: const Icon(Icons.add),
                  ),
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

  void reDraw() {
    setState(() {});
  }
}
