import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._(); //*To avoid creating instances

  static TextTheme xTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87),
    displayMedium: GoogleFonts.inter(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
    displaySmall: GoogleFonts.oswald(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black87),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black87),
    bodyLarge: GoogleFonts.oswald(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black87),
    bodyMedium: GoogleFonts.oswald(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black87),
  );
}
