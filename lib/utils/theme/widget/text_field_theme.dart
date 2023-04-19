import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme xInputDecorationTheme = InputDecorationTheme(
      prefixIconColor: primaryColor,
      floatingLabelStyle: const TextStyle(color: primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 2, color: primaryColor)));
}
