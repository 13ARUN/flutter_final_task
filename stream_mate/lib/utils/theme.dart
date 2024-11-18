import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 249, 220, 0),
    brightness: Brightness.dark);

final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.mochiyPopPOneTextTheme().apply(
    bodyColor: Colors.white,
  ),
);
