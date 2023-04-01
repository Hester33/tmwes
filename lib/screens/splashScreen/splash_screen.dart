import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/screens/login/login.dart';
import '../../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Stack(children: [
        Obx(
          () => AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            left: 60,
            top: splashController.animate.value ? 150 : 50,
            child: Image(image: AssetImage(logo)),
          ),
        ),
        Obx(
          () => AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: splashController.animate.value ? 280 : 100,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: splashController.animate.value ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Treat Migraine \nWeather Experience System',
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     Get.to(const Login());
        //   },
        //   child: const Text('Login'),
        // ),
      ]),
    );
  }
}
