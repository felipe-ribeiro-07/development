// ignore: file_names
import 'package:aula_05/themes/themes_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _temaAtual = ThemeMode.light;
  ThemeMode get temaAtual => _temaAtual;

  IconData get iconeAtual => _temaAtual == ThemeMode.light
      ? CupertinoIcons.moon
      : CupertinoIcons.sun_dust;

  void alternarTema() {
    _temaAtual = _temaAtual == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  static ThemeData construirTema(Brightness bright) {
    var color = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 8, 3, 34),
      brightness: bright,
    );

    if (bright == Brightness.dark) {
      color = color.copyWith(
        surface: const Color.fromARGB(255, 57, 56, 56),
        primary: const Color.fromARGB(255, 26, 19, 79),
        onPrimary: Colors.white,
        secondary: const Color(0xFF03DAC6),
      );
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: color,
      scaffoldBackgroundColor: bright == Brightness.dark
          ? const Color.fromARGB(86, 21, 21, 136)
          : null,
      appBarTheme: defineAppBar(color),
      bottomNavigationBarTheme: defineBottomAppBar(color),
      elevatedButtonTheme: defineElevatedButton(color),
    );
  }
}
