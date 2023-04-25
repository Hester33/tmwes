import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/controllers/signup_controller.dart';
import 'package:tmwes/models/user_model.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(SignUpController());
    // SignUpController controller = Get.find();
    final controller = SignUpController.instance;
    final _formKey = GlobalKey<FormState>();

    //! Name, DOB, Gender, Email, Phone no, Pwd, CPwd
    //! check box for term n cond
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //*Username
            TextFormField(
                controller: controller.username,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  label: Text('Username'),
                ),
                validator: (value) {
                  if (value.toString().length < 5) {
                    return 'Enter a valid name';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            //*Full Name
            TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  label: Text('Full Name'),
                ),
                validator: (value) {
                  if (value.toString().length < 5) {
                    return 'Enter a valid name';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            //*EmailAddress
            TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
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
            //*Password
            Obx(
              () => TextFormField(
                  obscureText: controller.isPwdHidden.value,
                  controller: controller.password,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline_outlined),
                    label: const Text('Password'),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isPwdHidden.value =
                              !controller.isPwdHidden.value;
                        },
                        icon: controller.isPwdHidden.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                  validator: (value) {
                    if (value.toString().length < 6) {
                      return 'Password should be longer or equal to 6 characters.';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 20),
            //*Confirm Password
            Obx(
              () => TextFormField(
                  obscureText: controller.isCPwdHidden.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline_outlined),
                    label: const Text('Confirm Password'),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isCPwdHidden.value =
                              !controller.isCPwdHidden.value;
                        },
                        icon: controller.isCPwdHidden.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                  validator: (value) {
                    if (value?.trim() != controller.password.text.trim()) {
                      return 'Passwords does not match!';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final String encryptedPwd = BCrypt.hashpw(
                      controller.password.text,
                      BCrypt.gensalt(),
                    );
                    //*Email & Pwd Authentication
                    /*SignUpController.instance.signUp(
                        controller.email.text.trim(),
                        controller.password.text.trim());*/
                    //-----------------------------------------------------------------------//
                    // final user = UserModel(
                    //   username: controller.username.text.trim(),
                    //   fullName: controller.fullName.text.trim(),
                    //   email: controller.email.text.trim(),
                    //   password: encryptedPwd,
                    // );
                    // SignUpController.instance.storeUser(
                    //     user,
                    //     controller.password.text.trim(),
                    //     controller.username.text.trim());
                    SignUpController.instance.storeUser(
                      controller.username.text.trim(),
                      controller.fullName.text.trim(),
                      controller.email.text.trim(),
                      controller.password.text.trim(),
                      encryptedPwd,
                    );
                  }
                },
                child: Text(
                  'Sign Up'.toUpperCase(),
                ),
              ),
            )
          ])),
    );
  }
}
