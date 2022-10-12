import 'package:flutter/material.dart';

class ApplicationColors {
  ApplicationColors._(); // this basically makes it so you can instantiate this class
  static const _blackPrimaryValue = 0xFF000000;
  static const secondaryTextColor = 0xFFcdcdcd;
  static const mainColor = Color.fromRGBO(120, 104, 230, 1);
  static const error = Colors.redAccent;
  static const white = Colors.white;
  static const brightness = Brightness.light;
  static const mainLightColor = Color.fromRGBO(184, 181, 255, 1);
  static const mainTextColor = Color.fromRGBO(165, 161, 251, 1);
  static const lightGrayColor = Color.fromRGBO(240, 240, 240, 1);

  static const MaterialColor black = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFFe0e0e0),
      100: Color(0xFFb3b3b3),
      200: Color(0xFF808080),
      300: Color(0xFF4d4d4d),
      400: Color(0xFF262626),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
}
