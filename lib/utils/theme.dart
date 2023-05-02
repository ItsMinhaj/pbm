import 'package:flutter/material.dart';

MaterialColor primaryMaterialColor = const MaterialColor(
  4278562850,
  <int, Color>{
    50: Color.fromRGBO(
      5,
      176,
      34,
      .1,
    ),
    100: Color.fromRGBO(
      5,
      176,
      34,
      .2,
    ),
    200: Color.fromRGBO(
      5,
      176,
      34,
      .3,
    ),
    300: Color.fromRGBO(
      5,
      176,
      34,
      .4,
    ),
    400: Color.fromRGBO(
      5,
      176,
      34,
      .5,
    ),
    500: Color.fromRGBO(
      5,
      176,
      34,
      .6,
    ),
    600: Color.fromRGBO(
      5,
      176,
      34,
      .7,
    ),
    700: Color.fromRGBO(
      5,
      176,
      34,
      .8,
    ),
    800: Color.fromRGBO(
      5,
      176,
      34,
      .9,
    ),
    900: Color.fromRGBO(
      5,
      176,
      34,
      1,
    ),
  },
);

ThemeData myTheme = ThemeData(
  fontFamily: "customFont",
  primaryColor: const Color(0xff05b022),
  primarySwatch: primaryMaterialColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xff05b022),
      ),
    ),
  ),
);
