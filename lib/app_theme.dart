import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData build() => ThemeData(
        primaryColor: Color.fromARGB(0xFF, 0xee, 0x72, 0x03),
        primaryColorDark: Color.fromARGB(0xFF, 0xd7, 0x66, 0x00),
        primaryColorLight: Color.fromARGB(0xFF, 0xf8, 0x9f, 0x4d),
        accentColor: Color.fromARGB(0xFF, 0x00, 0x95, 0x3A),
        backgroundColor: Color.fromARGB(0xFF, 0xFA, 0xFA, 0xFA),
        brightness: Brightness.light,
        //Fonts
        fontFamily: 'Roboto',
      );

  static Theme darkTheme({Widget child}) => Theme(
        data: ThemeData(
          primaryColor: Color.fromARGB(0xFF, 0xee, 0x72, 0x03),
          primaryColorDark: Color.fromARGB(0xFF, 0xd7, 0x66, 0x00),
          primaryColorLight: Color.fromARGB(0xFF, 0xf8, 0x9f, 0x4d),
          accentColor: Color.fromARGB(0xFF, 0x00, 0x95, 0x3A),
          backgroundColor: Color.fromARGB(0xFF, 0xee, 0x72, 0x03),
          brightness: Brightness.dark,
          errorColor: Color.fromARGB(0xFF, 0xFF, 0x9C, 0x40),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Color.fromARGB(0xFF, 0xd7, 0x66, 0x00),
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
