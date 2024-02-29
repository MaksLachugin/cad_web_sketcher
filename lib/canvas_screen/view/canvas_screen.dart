import 'package:cad_web_sketcher/canvas_screen/bloc/canvas_screen_bloc.dart';
import 'package:cad_web_sketcher/canvas_screen/widgets/widgets.dart';
import 'package:cad_web_sketcher/repo/models/base_element_enum.dart';
import 'package:cad_web_sketcher/repo/models/canvas_model.dart';
import 'package:cad_web_sketcher/repo/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final _canvasScreenBloc = CanvasScreenBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: BlocBuilder<CanvasScreenBloc, CanvasScreenState>(
        bloc: _canvasScreenBloc,
        builder: (context, state) {
          if (state is CanvasScreenDrawed || state is CanvasScreenInitial) {
            return Column(
              children: [
                canvasField(state.canvasModel),
                // SizedBox(height: 500, child: linesList(figure)),
                // TextButton(
                //   onPressed: () {
                //     _canvasScreenBloc.add(ReDrawCanvasScreen(canvasModel));
                //   },
                //   child: Container(
                //     padding:
                //         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //     child: const Text('Flat Button'),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        state.canvasModel.angle += 5;
                      },
                      child: const Text("+5"),
                    ),
                    TextButton(
                      onPressed: () {
                        state.canvasModel.angle -= 5;
                      },
                      child: const Text("-5"),
                    ),
                  ],
                ),
                SizedBox(
                  width: 250,
                  child: ExpansionTile(
                    title: const Text("Элементы кровли"),
                    children: List.generate(
                        RoofElements.values.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  _canvasScreenBloc.add(ReDrawCanvasScreen(
                                      CanvasModel.fromRoofElement(
                                          RoofElements.values[index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(RoofElements.values[index].name,
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            );
          }
          if (state is CanvasScreenLoadingFailure) return const Placeholder();

          return const SizedBox(
            height: 500,
            child: Card(
              color: Colors.black,
            ),
          );
        },
      )),
    );
  }

  ListView linesList(Figure figure) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return LineTile(
            figure: figure,
            index: i,
          );
        },
        // separatorBuilder: (context, index) => const Divider(),
        itemCount: figure.length);
  }

  Widget canvasField(CanvasModel canvasModel) {
    return Center(
      child: SizedBox(
        height: 700,
        width: 700,
        child: Card(
          color: const Color.fromARGB(255, 130, 138, 131),
          child: CanvasWidget(canvasModel: canvasModel),
        ),
      ),
    );
  }
}
