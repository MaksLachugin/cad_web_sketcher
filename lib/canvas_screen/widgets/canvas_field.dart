import 'package:cad_web_sketcher/canvas_screen/widgets/canvas_widget.dart';
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:flutter/material.dart';

class CanvasField extends StatelessWidget {
  const CanvasField(
      {super.key,
      required this.canvasModel,
      required this.selectedLine,
      required this.size,
      required this.rotate,
      required this.selectLine});
  final CanvasModel canvasModel;
  final int selectedLine;
  final Size size;
  final void Function(double) rotate;
  final void Function(int value) selectLine;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTapDown: (details) {
              var i = canvasModel.indexOfNearLine(
                  details.localPosition, size, selectedLine);
              if (i == selectedLine) {
                i = -1;
              }
              selectLine(i);
            },
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Container(
                color: const Color.fromARGB(255, 193, 201, 194),
                child: CanvasWidget(
                  canvasModel: canvasModel,
                  selected: selectedLine,
                  isPrerender: false,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Поворот элемента на эскизе: ",
                    style: textTheme.bodyLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      rotate(-5);
                    },
                    icon: const Icon(Icons.rotate_left),
                  ),
                  IconButton(
                    onPressed: () {
                      rotate(5);
                    },
                    icon: const Icon(Icons.rotate_right),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
