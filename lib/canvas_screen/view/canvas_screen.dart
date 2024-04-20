import 'dart:math';

import 'package:cad_web_sketcher/canvas_screen/bloc/canvas_screen_bloc.dart';
import 'package:cad_web_sketcher/canvas_screen/widgets/canvas_field.dart';
import 'package:cad_web_sketcher/canvas_screen/widgets/widgets.dart';
import 'package:cad_web_sketcher/repo/server/pocketbase_server.dart';
import 'package:cad_web_sketcher/repo/server/server_models/order.dart';
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:cad_web_sketcher/widgets/order_form_widget/order_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  List<bool> _isSelectedStart = [false, false, false];
  List<bool> _isSelectedEnd = [false, false, false];
  final _canvasScreenBloc = CanvasScreenBloc();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    String vers = _packageInfo.version;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          BlocBuilder<CanvasScreenBloc, CanvasScreenState>(
            bloc: _canvasScreenBloc,
            builder: (context, state) {
              if (state is CanvasScreenDrawed || state is CanvasScreenInitial) {
                Size widgetSize = MediaQuery.of(context).size;

                var size = widgetSize.width >= 900
                    ? min(widgetSize.width - 300, widgetSize.height - 100)
                    : min(widgetSize.width - 100, widgetSize.height - 100);
                Size canvasSize = Size(size, size);
                CanvasModel model = state.canvasModel;
                int selectedLine = state.selectedLine;
                _isSelectedStart = setTrueInListOfFalse(_isSelectedStart,
                    Bending.values.indexOf(model.getStartBending()));
                _isSelectedEnd = setTrueInListOfFalse(_isSelectedEnd,
                    Bending.values.indexOf(model.getEndBending()));
                return Flex(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  direction:
                      widgetSize.width >= 900 ? Axis.horizontal : Axis.vertical,
                  children: [
                    CanvasField(
                      canvasModel: model,
                      selectedLine: selectedLine,
                      size: canvasSize,
                      rotate: rotate,
                      newFigure: callNewFigure,
                      selectLine: selectLine,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("Начальный подгиб"),
                              ),
                              ToggleButtons(
                                isSelected: _isSelectedStart,
                                onPressed: (index) {
                                  setState(() {
                                    if (!_isSelectedStart[index]) {
                                      _isSelectedStart =
                                          List.generate(3, (index) => false);
                                      _isSelectedStart[index] =
                                          !_isSelectedStart[index];
                                      model.setStartBending(
                                          Bending.values[index]);
                                    }
                                  });
                                },
                                children: const [
                                  Icon(Icons.arrow_left),
                                  Icon(Icons.remove),
                                  Icon(Icons.arrow_right),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Конечный подгиб"),
                              ),
                              ToggleButtons(
                                isSelected: _isSelectedEnd,
                                onPressed: (index) {
                                  setState(() {
                                    if (!_isSelectedEnd[index]) {
                                      _isSelectedEnd =
                                          List.generate(3, (index) => false);
                                      _isSelectedEnd[index] =
                                          !_isSelectedEnd[index];
                                      model
                                          .setEndBending(Bending.values[index]);
                                    }
                                  });
                                },
                                children: const [
                                  Icon(Icons.arrow_left),
                                  Icon(Icons.remove),
                                  Icon(Icons.arrow_right),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: selectedLine != -1
                              ? LineTile(
                                  index: selectedLine,
                                  line: model.figure.lines[selectedLine],
                                  changeLineCall: (int index, Line newLine) {
                                    // Переписать на блок
                                    setState(() {
                                      model.changeLine(index, newLine);
                                    });
                                  },
                                  insertNewLine: (int index) {
                                    setState(() {
                                      model.insertNewLine(index);
                                    });
                                  },
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 250,
                            child: OrderFormWidget(sendDataOrder: sendOrder),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 250,
                            child: TextField(
                              onSubmitted: (value) {
                                _canvasScreenBloc.add(LoadNewFigure(id: value));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state is CanvasScreenLoadingFailure) {
                return const Placeholder();
              }

              return const SizedBox(
                height: 500,
                child: Card(
                  color: Colors.black,
                ),
              );
            },
          ),
          Text(
            "v$vers",
            style: textTheme.bodyLarge,
          ),
        ],
      )),
    );
  }

  void callNewFigure(Enum value) {
    _canvasScreenBloc.add(CallNewFigureCanvasScreen(value));
  }

  void rotate(double v) {
    _canvasScreenBloc.add(RotateCanvasScreen(v));
  }

  void selectLine(int v) {
    _canvasScreenBloc.add(SelectLineCanvasScreen(v));
  }

  void sendOrder(
      String customer,
      String number,
      String email,
      String comment,
      String width,
      String count,
      String color,
      String thickness,
      String selectedStatus) {
    PocketbaseServer().sendOrder(Order(
      customer: customer,
      number: number,
      email: email,
      comment: comment,
      figure_json: _canvasScreenBloc.state.canvasModel.figure.toJson(),
      figure_len: _canvasScreenBloc.state.canvasModel.figure.calkFigureLen(),
      width: width,
      count: count,
      status: selectedStatus,
      color: color,
      thickness: thickness,
    ));
  }

  ListView canvasModelEditor(CanvasModel model) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return LineTile(
            index: i,
            line: model.figure.lines[i],
            changeLineCall: (int index, Line newLine) {
              setState(() {
                model.changeLine(index, newLine);
              });
            },
            insertNewLine: (int index) {
              setState(() {
                model.insertNewLine(index);
              });
            },
          );
        },
        // separatorBuilder: (context, index) => const Divider(),
        itemCount: model.figure.lines.length);
  }
}

List<bool> setTrueInListOfFalse(List<bool> list, index) {
  var res = List.generate(list.length, (index) => false);
  res[index] = true;
  return res;
}
