import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cad_web_sketcher/router/router.dart';
import 'package:cad_web_sketcher/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

class CadWebSketcher extends StatelessWidget {
  const CadWebSketcher({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      dark: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Чертежник',
        routes: routes,
        theme: theme,
        darkTheme: darkTheme,
      ),
    );
  }
}
