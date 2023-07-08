import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/screens/authentication/login/forgot_password_screen.dart';

class ForgotPasswordBtn extends StatelessWidget {
  const ForgotPasswordBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Get.to(() => const ForgotPasswordScreen());
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 13),
          ),
        ));
  }
}
