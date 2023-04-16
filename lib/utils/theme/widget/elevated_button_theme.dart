import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //*To avoid creating instances

  static final xElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        side: const BorderSide(color: Colors.black54),
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        textStyle: const TextStyle(fontSize: 16.0)),
  );
}
