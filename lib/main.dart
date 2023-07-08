import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/services/authentication_db.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:tmwes/utils/theme/theme.dart';

import 'helpers/init_controller.dart';

//!flutter pub upgrade --major-version

void main() async {
  // Initialize date formatting for the 'ms_MY' locale (Malay language in Malaysia)
  await initializeDateFormatting('en_MY');
  WidgetsFlutterBinding.ensureInitialized();
  //hide system bottom navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthenticationDb());
    //   // Get.put(UserDb());
    //   //init();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      title: 'TMWES',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.xTheme,
      home: const Center(
          child: CircularProgressIndicator(
        backgroundColor: primaryColor,
      )),
    );
  }
}
