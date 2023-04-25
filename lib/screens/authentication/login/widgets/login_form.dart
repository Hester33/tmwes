import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/controllers/login_controller.dart';
import 'package:tmwes/screens/authentication/login/widgets/forget_password.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // !final controller = Get.put(LoginController());
    // LoginController controller = Get.find();
    final controller = LoginController.instance;
    final _formKey = GlobalKey<FormState>();
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: 'Email',
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            Obx(
              () => TextFormField(
                obscureText: controller.isPwdHidden.value,
                controller: controller.password,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelText: 'Password',
                  hintText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.isPwdHidden.value =
                            !controller.isPwdHidden.value;
                      },
                      icon: controller.isPwdHidden.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                ),
              ),
            ),
            const ForgotPasswordBtn(),
            //const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //if (_formKey.currentState!.validate()) {
                  LoginController.instance.login(controller.email.text.trim(),
                      controller.password.text.trim());
                  //}
                },
                child: Text(
                  'Login'.toUpperCase(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
