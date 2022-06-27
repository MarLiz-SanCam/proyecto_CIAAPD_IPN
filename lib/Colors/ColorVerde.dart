// Archivo para definir la paleta de colores ESIME
import 'package:flutter/material.dart';

//Paleta de colores basada en logo ESIME
class ColorVerde {
  static const MaterialColor verde = const MaterialColor(
    0xff00843f, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff80c29f ),//10%
      100: const Color(0xff66b58c),//20%
      200: const Color(0xff4da979),//30%
      300: const Color(0xff339d65),//40%
      400: const Color(0xff1a9052),//50%
      500: const Color(0xff007739),//60%
      600: const Color(0xff005c2c),//70%
      700: const Color(0xff004f26),//80%
      800: const Color(0xff004220),//90%
      900: const Color(0xff003519),//100%
    },
  );
}