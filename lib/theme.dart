import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData dreavyTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    headline1: GoogleFonts.permanentMarker(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: <Color>[
              Colors.black38,
              Colors.black,
            ],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 72.0))),
    headline3: GoogleFonts.permanentMarker(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    bodyText1: const TextStyle(
        color: Color.fromRGBO(220, 220, 220, 1.0), fontSize: 16),
    bodyText2:
        const TextStyle(color: Color.fromRGBO(220, 220, 220, 1.0), fontSize: 8),
  ),
);
