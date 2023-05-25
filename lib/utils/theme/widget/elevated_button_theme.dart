import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //*To avoid creating instances

  static final xElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        //side: const BorderSide(color: Colors.black54),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        textStyle: const TextStyle(fontSize: 16.0)),
  );
}
