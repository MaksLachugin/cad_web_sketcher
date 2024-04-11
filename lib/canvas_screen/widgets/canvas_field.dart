import 'package:cad_web_sketcher/canvas_screen/widgets/canvas_widget.dart';
import 'package:cad_web_sketcher/canvas_screen/widgets/expansions_tile_from_enums.dart';
import 'package:cad_web_sketcher/repo/models/base_element_enum.dart';
import 'package:cad_web_sketcher/repo/models/canvas_model.dart';
import 'package:flutter/material.dart';

class CanvasField extends StatelessWidget {
  const CanvasField(
      {super.key,
      required this.canvasModel,
      required this.selectedLine,
      required this.size,
      required this.rotate,
      required this.newFigure,
      required this.selectLine});
  final CanvasModel canvasModel;
  final int selectedLine;
  final Size size;
  final void Function(double) rotate;
  final void Function(Enum value) newFigure;
  final void Function(int value) selectLine;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var values = [
      (RoofElements.abutment.className, RoofElements.values),
      (Parapets.flat.className, Parapets.values)
    ];
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
                    canvasModel: canvasModel, selected: selectedLine),
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
              ExpansionsTileFromEnums(
                name: "Готовые элементы",
                values: values,
                callNewFigure: newFigure,
              )
            ],
          ),
        ],
      ),
    );
  }
}
