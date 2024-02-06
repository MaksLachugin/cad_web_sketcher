import 'package:cad_web_sketcher/canvas_screen/bloc/canvas_screen_bloc.dart';
import 'package:cad_web_sketcher/canvas_screen/widgets/canvasWidget.dart';
import 'package:cad_web_sketcher/repo/models/figure.dart';
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
            var figure = state.figure;
            return Column(
              children: [
                canvasField(figure),
                sendButtonWidget(),
              ],
            );
          }
          return Container();
        },
      )),
    );
  }

  Widget canvasField(Figure figure) {
    return Center(
      child: SizedBox(
        height: 700,
        width: 700,
        child: Card(
          color: const Color.fromARGB(255, 130, 138, 131),
          child: MyCanvasWidget(figure: figure),
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
