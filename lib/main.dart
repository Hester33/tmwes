import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tmwes/screens/home/home.dart';
import 'package:tmwes/screens/splashScreen/splash_screen.dart';
import 'package:tmwes/utils/theme/theme.dart';

//!flutter pub upgrade --major-version

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationDb()));
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
      home: const Center(child: CircularProgressIndicator()),
    );
  }
}
