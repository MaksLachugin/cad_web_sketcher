import 'package:cad_web_sketcher/canvas_screen/widgets/expansion_tile_by_enum_list.dart';
import 'package:cad_web_sketcher/repo/sketcher_models/models.dart';
import 'package:flutter/material.dart';

class ExpansionsTileFromEnums extends StatelessWidget {
  final void Function(Enum value) callNewFigure;

  const ExpansionsTileFromEnums(
      {super.key,
      required this.name,
      required this.values,
      required this.callNewFigure});

  final String name;
  final List<(String, List<Enum>)> values;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 270,
        child: ExpansionTile(
          title: const Text("Готовые элементы"),
          children: List.generate(values.length, (index) {
            var val = values[index];
            return ExpansionTileByEnumList(
              name: val.$1,
              onPress: callNewFigure,
              values: val.$2.map((e) => (e, getNameOfEnum(e))).toList(),
            );
          }),
        ));
  }
}
