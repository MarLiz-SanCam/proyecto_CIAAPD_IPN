
import 'package:flutter/material.dart';
import 'package:proyecto_app_asistencia_ipn/Colors/ColorVino.dart';
import 'package:proyecto_app_asistencia_ipn/Pages/HomePage.dart';
// --------------------------  Fin de los 'import' -------------------------- //

// Función Main de la aplicación
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Control Asistencias",
    home: HomePage(), // Página principal de la aplicación
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorVino.vino,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorVino.vino),
    ),
  ),
);