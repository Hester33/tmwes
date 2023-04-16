import 'package:flutter/material.dart';

import 'widget/elevated_button_theme.dart';
import 'widget/outlined_button_theme.dart';
import 'widget/text_field_theme.dart';
import 'widget/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData xTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    textTheme: TTextTheme.xTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.xOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.xElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.xInputDecorationTheme,
  );
}
