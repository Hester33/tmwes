import 'package:flutter/material.dart';
import 'package:tmwes/constants/image.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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

              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {},
                child: Text.rich(
                  TextSpan(
                      text: 'Already have an account?',
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: const [
                        TextSpan(
                            text: 'Sign up',
                            style: TextStyle(color: Colors.blue)),
                      ]),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
