import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/screens/authentication/login/widgets/forget_password.dart';
import 'package:tmwes/screens/authentication/signup/signup_screen.dart';

import '../../../database/authentication_db.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //! final _authDb = Get.put(AuthenticationDb());
    AuthenticationDb _authDb = Get.find();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Image(
                image: AssetImage(logo),
                height: size.height * 0.3,
              ),

              /* --- Form --- */
              const LoginForm(),
              /* --- End --- */
//  Widget forgotPassword() {
//     return
//! Modify
              //}
              // TextButton(
              //   onPressed: () {
              //     Get.off(() => const SignUpScreen());
              //   },
              //   child:
              Text.rich(
                TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                          text: 'SIGN UP',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.off(() => const SignUpScreen());
                            }),
                    ]),
              ),
              //)
            ],
          ),
        )),
      ),
    );
  }
}
