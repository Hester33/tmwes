import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme xInputDecorationTheme = InputDecorationTheme(
      prefixIconColor: primaryColor,
      floatingLabelStyle: TextStyle(color: primaryColor),
      border: OutlineInputBorder(),
      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      focusedBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(width: 2, color: primaryColor)));
}
