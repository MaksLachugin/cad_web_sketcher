import 'package:flutter/material.dart';

class ThreePosButton extends StatefulWidget {
  const ThreePosButton({super.key});

  @override
  State<ThreePosButton> createState() => _ThreePosButtonState();
}

class _ThreePosButtonState extends State<ThreePosButton> {
  int selectedButtonIndex = 0;
  List<Widget> buttons = [
    const Icon(Icons.share),
    const Icon(Icons.copy),
    const Icon(Icons.link),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        isSelected: List.generate(
            buttons.length, (index) => index == selectedButtonIndex),
        constraints: const BoxConstraints(
          minWidth: 75,
          minHeight: 50,
        ),
        onPressed: (int index) => setState(() => selectedButtonIndex = index),
        children: buttons,
      ),
    );
  }
}
