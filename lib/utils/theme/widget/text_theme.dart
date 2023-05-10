import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._(); //*To avoid creating instances

  static TextTheme xTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
        fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.black87),
    displayMedium: GoogleFonts.inter(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
    displaySmall: GoogleFonts.lato(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black87),
    headlineMedium: GoogleFonts.inter(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black87),
    bodyLarge: GoogleFonts.lato(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: GoogleFonts.lato(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black87),
  );
}
