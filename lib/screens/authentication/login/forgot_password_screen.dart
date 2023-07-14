import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/controllers/login_controller.dart';
import 'package:tmwes/screens/welcome/welcome_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        elevation: 0,
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please enter your email to reset the password.',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: formKey,
                        child: Column(children: [
                          TextFormField(
                              controller: controller.email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                label: Text('Email'),
                              ),
                              validator: (value) {
                                bool isEmailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!);
                                if (!isEmailValid) {
                                  return 'Invalid email.';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.showLoading.value = true;
                                      controller.resetPwd(
                                          controller.email.text.trim());
                                      Get.defaultDialog(
                                        titlePadding:
                                            const EdgeInsets.only(top: 15),
                                        title: "Email sent!",
                                        middleText:
                                            "Please check your email to reset the password.",
                                        titleStyle: const TextStyle(
                                            color: Colors.green),
                                        middleTextStyle: const TextStyle(
                                            color: Colors.blueGrey),
                                        textConfirm: "Ok",
                                        confirmTextColor: Colors.white,
                                        onConfirm: () => Get.offAll(
                                            () => const WelcomeScreen()),
                                        barrierDismissible: false,
                                      );
                                      controller.showLoading.value = false;
                                    }
                                  },
                                  child: controller.showLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text('Send Verification Email')),
                            ),
                          ),
                        ]),
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
