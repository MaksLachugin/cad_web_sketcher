import 'package:flutter/material.dart';

class ExpansionTileByEnumList extends StatelessWidget {
  const ExpansionTileByEnumList({
    super.key,
    required this.onPress,
    required this.values,
    required this.name,
  });
  final String name;
  final List<(Enum, String, String)> values;
  final Function(Enum value) onPress;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 300,
      child: ExpansionTile(
        title: Text(
          name,
          style: textTheme.bodyLarge,
        ),
        children: List.generate(
          values.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                onPress(values[index].$1);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      values[index].$3,
                      scale: 8,
                    ),
                    Text(values[index].$2, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
