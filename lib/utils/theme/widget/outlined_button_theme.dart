import 'package:flutter/material.dart';


class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //*To avoid creating instances

  static final xOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.black54),
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        textStyle: const TextStyle(fontSize: 16.0)),
  );
}
