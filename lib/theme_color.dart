import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor themeColor = MaterialColor(
    0xfff5b04c, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xfff5b04c), //10%
      100: Color(0xfff5b04c), //20%
      200: Color(0xfff5b04c), //30%
      300: Color(0xfff5b04c), //40%
      400: Color(0xfff5b04c), //50%
      500: Color(0xfff5b04c), //60%
      600: Color(0xfff5b04c), //70%
      700: Color(0xfff5b04c), //80%
      800: Color(0xfff5b04c), //90%
      900: Color(0xfff5b04c), //100%
    },
  );
} // you can d
