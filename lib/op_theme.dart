import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData build() => ThemeData(
        primaryColor: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
        primaryColorDark: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
        primaryColorLight: Color.fromARGB(0xFF, 0x55, 0x96, 0xD6),
        accentColor: Color.fromARGB(0xFF, 0x8B, 0xC3, 0x4A),
        backgroundColor: Color.fromARGB(0xFF, 0xFA, 0xFA, 0xFA),
        brightness: Brightness.light,
        //Fonts
        fontFamily: 'Roboto',
      );

  static Theme darkTheme({Widget child}) => Theme(
        data: ThemeData(
          primaryColor: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
          primaryColorDark: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
          primaryColorLight: Color.fromARGB(0xFF, 0x55, 0x96, 0xD6),
          accentColor: Color.fromARGB(0xFF, 0x8B, 0xC3, 0x4A),
          backgroundColor: Color.fromARGB(0xFF, 0x19, 0x76, 0xD2),
          brightness: Brightness.dark,
          errorColor: Color.fromARGB(0xFF, 0xFF, 0x9C, 0x40),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Color.fromARGB(0xFF, 0x0A, 0x56, 0xA1),
          ),
          textTheme: TextTheme(
              display3: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
              display1: TextStyle(color: Colors.white, fontWeight: FontWeight.w100)
          ),
          fontFamily: 'Roboto',
        ),
        child: child,
      );
}
