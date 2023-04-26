import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/controllers/profile_controller.dart';
import 'package:tmwes/controllers/signup_controller.dart';
import 'package:tmwes/models/user_model.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';

import '../../constants/image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    final signUpController = SignUpController.instance;
    final controller = ProfileController.instance;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text('Edit Profile',
            style: Theme.of(context).textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder(
          //the getUserData() function will store the data in future
          future: controller.getUserData(),
          builder: (context, snapshot) {
            //if data is completely fetched
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                //map snapshot data to UserModel
                UserModel userData = snapshot.data as UserModel;

                //Controllers
                final username = TextEditingController(text: userData.username);
                final fullName = TextEditingController(text: userData.fullName);
                // final dob = TextEditingController(
                //         text: controller.formatDate(userData.dateOfBirth))
                //     .obs; //!obs??
                signUpController.dob.value.text =
                    controller.formatDate(userData.dateOfBirth);
                final email = TextEditingController(text: userData.email);
                final phoneNo =
                    TextEditingController(text: userData.phoneNumber);

                var isPwdHidden = true.obs;
                var isCPwdHidden = true.obs;

                return Column(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      //child: ClipRRect(borderRadius: BorderRadius.circular(100), child: Image(image: AssetImage(profile))),
                      child: Image(image: AssetImage(profile)),
                    ),
                    const SizedBox(height: 30),
                    Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //*Username
                              TextFormField(
                                  controller: username,
                                  decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person_outline_outlined),
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
                                  controller: fullName,
                                  decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person_outline_outlined),
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
                                    controller: signUpController.dob.value,
                                    decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.date_range_outlined),
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
                                      signUpController.chooseDate();
                                    }),
                              ),
                              const SizedBox(height: 20),
                              //*EmailAddress
                              TextFormField(
                                  controller: email,
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
                                  controller: phoneNo,
                                  decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.phone_android_outlined),
                                    label: Text('Phone Number'),
                                  ),
                                  validator: (value) {
                                    bool isPhoneNoValid =
                                        RegExp(r'(^(?:[+])?[0-9]{10,12}$)')
                                            .hasMatch(value!);
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

                              //------------------------------------------------------------------------------------//
                              //*Date Joined
                              // TextFormField(
                              //   initialValue:
                              //       controller.formatDate(userData.dateJoined),
                              //   decoration: const InputDecoration(
                              //       prefixIcon:
                              //           Icon(Icons.password), //! change icon
                              //       label: Text('Date Joined: '),
                              //       //!Test
                              //       border: InputBorder.none),
                              //   readOnly: true,
                              // ),
                              // const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //if (_formKey.currentState!.validate() && isAgree==true) {
                                    if (_formKey.currentState!.validate()) {
                                      final userDetails = UserModel(
                                          id: userData.id,
                                          username: username.text.trim(),
                                          fullName: fullName.text.trim(),
                                          dateOfBirth:
                                              SignUpController.pickedDate !=
                                                      null
                                                  ? SignUpController.pickedDate!
                                                  : userData.dateOfBirth,
                                          email: email.text.trim(),
                                          phoneNumber: phoneNo.text.trim(),
                                          dateJoined: userData.dateJoined);

                                      await controller
                                          .updateUserDetails(userDetails);
                                    }
                                    //Get.offAll(() => const ProfileScreen());
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ),
                              //------------------------------------------------------------------------------------//
                            ])),
                    //! Form(
                    //     child: Column(
                    //   children: [
                    //     //*Username
                    //     TextFormField(
                    //       initialValue: userData.username,
                    //       decoration: const InputDecoration(
                    //         prefixIcon: Icon(Icons.person_outline_outlined),
                    //         label: Text('Username'),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 20),
                    //     //*Full Name
                    //     TextFormField(
                    //       initialValue: userData.fullName,
                    //       decoration: const InputDecoration(
                    //         prefixIcon: Icon(Icons.person_outline_outlined),
                    //         label: Text('Full Name'),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 20),
                    //     //*EmailAddress
                    //     TextFormField(
                    //       initialValue: userData.email,
                    //       decoration: const InputDecoration(
                    //         prefixIcon: Icon(Icons.email_outlined),
                    //         label: Text('Email'),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 20),
                    //     //*Password
                    //     TextFormField(
                    //       decoration: const InputDecoration(
                    //           prefixIcon: Icon(Icons.password),
                    //           label: Text('Password'),
                    //           suffixIcon: IconButton(
                    //               onPressed: null,
                    //               icon: Icon(Icons.remove_red_eye_sharp))),
                    //     ),
                    //     const SizedBox(height: 20),
                    //     //*Date Joined
                    //     TextFormField(
                    //       initialValue: controller.formatDate(userData.dateJoined),
                    //       decoration: const InputDecoration(
                    //           prefixIcon: Icon(Icons.password),
                    //           label: Text('Date Joined: '),
                    //           suffixIcon: IconButton(
                    //               onPressed: null,
                    //               icon: Icon(Icons.remove_red_eye_sharp)),
                    //               //!Test
                    //               border: InputBorder.none),
                    //               readOnly: true,
                    //     ),
                    //     const SizedBox(height: 20),
                    //     SizedBox(
                    //       width: double.infinity,
                    //       child: ElevatedButton(
                    //         onPressed: () {},
                    //         child: const Text('Confirm'),
                    //       ),
                    //     )
                    //   ],
                    // ))
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text("Something went wrong."),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      )),
    );
  }
}
