// ignore_for_file: file_names

import 'package:aula_05/controller/themeController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia de turismo"),
        actions: [
          Consumer<ThemeController>(
            builder: (context, controllerThemeHome, Widget? child) =>
                IconButton(
                  onPressed: () => controllerThemeHome.alternarTema() ,
                  icon: Icon(controllerThemeHome.iconeAtual),
                ),
          ),
        ],
      ),
    );
  }
}
