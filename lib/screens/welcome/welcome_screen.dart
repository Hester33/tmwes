import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/screens/authentication/login/login_screen.dart';
import 'package:tmwes/widgets/animation/controller_fade_in_aniamtion.dart';
import 'package:tmwes/widgets/animation/fade_in_animation.dart';
import 'package:tmwes/widgets/animation/model_fade_in_animation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            FadeInAnimation(
              durationInMs: 1200,
              animate: AnimationPosition(
                bottomAfter: 0,
                bottomBefore: -100,
                leftBefore: 0,
                leftAfter: 0,
                topBefore: 0,
                topAfter: 0,
                rightBefore: 0,
                rightAfter: 0,
              ),
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image(image: AssetImage(logo)),
                          const SizedBox(height: 20),
                          Text(
                            'Treat Migraine \nWeather Experience System',
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => LoginScreen());
                            //! testing
                            controller.fadeOut();
                          },
                          child: Text(
                            'Login'.toUpperCase(),
                            //style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  'Sign Up'.toUpperCase(),
                                  //style: const TextStyle(fontWeight: FontWeight.bold),
                                ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
