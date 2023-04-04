import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/widgets/animation/fade_in_animation.dart';
import 'package:tmwes/widgets/animation/model_fade_in_animation.dart';
import '../../widgets/animation/controller_fade_in_aniamtion.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    return Scaffold(
      body: Stack(children: [
        FadeInAnimation(
          durationInMs: 1600,
          animate: AnimationPosition(
            topAfter: 150,
            topBefore: 50,
            leftAfter: 60,
            leftBefore: 60,
          ),
          child: Image(image: AssetImage(logo)),
          //!child: Image(image: AssetImage(logo),height: MediaQuery.of(context).size.height * 0.5,),
        ),
        FadeInAnimation(
          durationInMs: 1600,
          animate: AnimationPosition(
            bottomAfter: 180,
            bottomBefore: 80,
            leftAfter: 30,
            leftBefore: 30,
          ),
          child: Text(
            'Treat Migraine \nWeather Experience System',
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
