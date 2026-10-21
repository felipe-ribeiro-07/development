import 'package:flutter/material.dart';

// ignore: strict_top_level_inference
AppBarTheme defineAppBar (color){
  return AppBarTheme(
        centerTitle: true,
        backgroundColor: color.primary,
        foregroundColor: color.onPrimary,
        elevation: 4,
      );
}

// ignore: strict_top_level_inference
BottomNavigationBarThemeData defineBottomAppBar (color){
  return BottomNavigationBarThemeData(
        backgroundColor : color.primary ,
        elevation: 4
      );
}

// ignore: strict_top_level_inference
ElevatedButtonThemeData defineElevatedButton (color){
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(

    )
  );
}