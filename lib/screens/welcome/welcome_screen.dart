import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/screens/authentication/login/login_screen.dart';
import 'package:tmwes/screens/authentication/signup/signup_screen.dart';
import 'package:tmwes/widgets/animation/controller_fade_in_aniamtion.dart';
import 'package:tmwes/widgets/animation/fade_in_animation.dart';
import 'package:tmwes/widgets/animation/model_fade_in_animation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(FadeInAnimationController());
    final controller = FadeInAnimationController.instance;
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
                topBefore: -50,
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
                                textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xffe0e0e0))),
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
                            //! testing (seems like not working)
                            //controller.fadeOut();
                            Get.off(() => const LoginScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black54),
                          child: Text('Login'.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        )),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Get.off(() => const SignUpScreen());
                                },
                                //!testing the style
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(width: 1.5)),
                                child: Text(
                                  'Sign Up'.toUpperCase(),

                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),

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
