import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //*To avoid creating instances

  static final xElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(),
        foregroundColor: Colors.white70,
        backgroundColor: Colors.black54,
        side: BorderSide(color: Colors.black54),
        padding: EdgeInsets.symmetric(vertical: 15.0)),
  );
}
