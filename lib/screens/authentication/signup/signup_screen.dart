import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/screens/authentication/login/login_screen.dart';

import 'widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Sign Up',
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
                /* --- Signup Form --- */
                const SignUpForm(),
                /* ---- End --- */
                // TextButton(
                //   onPressed: () {
                //     //!disable user to click the btn if the field is empty
                //     //          ElevatedButton(
                //     // onPressed: agree ? _doSomething : null,
                //     // child: const Text('Continue'))
                //     Get.off(() => const LoginScreen());
                //   },
                //child:
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                        text: 'LOGIN',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.off(() => const LoginScreen());
                          }),
                  ]),
                ),
                //)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
