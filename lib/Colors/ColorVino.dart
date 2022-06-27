// Archivo para definir la paleta de colores principal
import 'package:flutter/material.dart';
// you can define define int 500 as the default shade and add your lighter tints above and darker tints below.

class ColorVino {
  static const MaterialColor vino = const MaterialColor(
    0xff5e2129, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffaf9094 ),//10%
      100: const Color(0xff9e7a7f),//20%
      200: const Color(0xff8e6469),//30%
      300: const Color(0xff7e4d54),//40%
      400: const Color(0xff6e373e),//50%
      500: const Color(0xff551e25),//60%
      600: const Color(0xff4b1a21),//70%
      700: const Color(0xff42171d),//80%
      800: const Color(0xff381419),//90%
      900: const Color(0xff2f1115),//100%
    },
  );
}