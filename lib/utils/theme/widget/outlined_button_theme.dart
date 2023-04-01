import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //*To avoid creating instances

  static final xOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.black54),
        padding: EdgeInsets.symmetric(vertical: 15.0)),
  );
}
