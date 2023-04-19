import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/controllers/profile_controller.dart';
import 'package:tmwes/models/user_model.dart';

import '../../constants/image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
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
                        child: Column(
                      children: [
                        //*Username
                        TextFormField(
                          initialValue: userData.username,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            label: Text('Username'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //*Full Name
                        TextFormField(
                          initialValue: userData.fullName,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            label: Text('Full Name'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //*EmailAddress
                        TextFormField(
                          initialValue: userData.email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            label: Text('Email'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //*Password
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              label: Text('Password'),
                              suffixIcon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.remove_red_eye_sharp))),
                        ),
                        const SizedBox(height: 20),
                        //*Confirm Password
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              label: Text('Confirm Password'),
                              suffixIcon: IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.remove_red_eye_sharp))),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Confirm'),
                          ),
                        )
                      ],
                    ))
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
