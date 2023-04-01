import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Login'.toUpperCase()),
                  )),
                  const SizedBox(width: 10.0),
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Text('Sign Up'.toUpperCase()))),
                ],
              )
            ],
          ),
        ));
  }
}
