import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tmwes/screens/splashScreen/splash_screen.dart';
import 'package:tmwes/screens/welcome/welcome_screen.dart';
import 'package:tmwes/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TMWES',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.xTheme,
      home: WelcomeScreen(),
    );
  }
}
