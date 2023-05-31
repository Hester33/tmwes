import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/controllers/signup_controller.dart';
import 'package:tmwes/models/user_model.dart';

import '../../login/login_screen.dart';

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
                    return 'Please enter you username name';
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
                    return 'Please enter your full name';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            //*D.O.B
            Obx(
              () => TextFormField(
                  controller: controller.dob.value,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.date_range_outlined),
                    label: Text('D.O.B'),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                  //!not sure
                  //keyboardType: TextInputType.number,
                  onTap: () {
                    //final DateTime date = controller.chooseDate() as DateTime;
                    controller.chooseDate();
                  }),
            ),
            const SizedBox(height: 20),
            //*EmailAddress
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
                  if (value.toString().isEmpty) {
                    return 'Please enter your email.';
                  } else if (!isEmailValid) {
                    return 'Invalid email.';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            //* Phone Number
            TextFormField(
                controller: controller.phoneNo,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  label: Text('Phone Number'),
                  //! test
                  //hintText: '+6012345678',
                ),
                validator: (value) {
                  bool isPhoneNoValid =
                      RegExp(r'(^(?:[+])?[0-9]{10,12}$)').hasMatch(value!);
                  if (value.toString().isEmpty) {
                    return 'Please enter your phone number.';
                  } else if (value.toString().length < 12) {
                    return 'Invalid phone number.';
                  } else if (!isPhoneNoValid) {
                    return 'Please enter a valid phone number.';
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
                    prefixIcon: const Icon(Icons.password_outlined),
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
                    prefixIcon: const Icon(Icons.password_outlined),
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
            const SizedBox(height: 10),
            //! add term n cond
            Obx(
              () => Row(
                children: [
                  Checkbox(
                    value: controller.isAgree.value,
                    onChanged: (value) {
                      controller.isAgree.value = value ?? false;
                    },
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          text: "I have read and agree to the ",
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                                text: 'Terms and Conditions.',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.termsAndConditionsDialog();
                                  }),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isAgree.value
                      ? () {
                          //if (_formKey.currentState!.validate() && isAgree==true) { onPressed: agree ? _doSomething : null,
                          if (_formKey.currentState!.validate()) {
                            final String encryptedPwd = BCrypt.hashpw(
                              controller.password.text,
                              BCrypt.gensalt(),
                            );
                            SignUpController.instance.storeUser(
                              controller.username.text.trim(),
                              controller.fullName.text.trim(),
                              controller.email.text.trim(),
                              controller.password.text.trim(),
                              controller.phoneNo.text.trim(),
                            );
                          }
                        }
                      : null,
                  child: Text(
                    'Sign Up'.toUpperCase(),
                  ),
                ),
              ),
            ),
            // Obx(
            //   () => controller.isAgree.value
            //       ? Text("")
            //       : const Text(
            //           "Please accept the term and condition.",
            //           style: TextStyle(color: Colors.red),
            //         ),
            // ),
          ])),
    );
  }
}
