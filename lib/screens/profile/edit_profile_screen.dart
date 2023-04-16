import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              //child: ClipRRect(borderRadius: BorderRadius.circular(100), child: Image(image: AssetImage(profile))),
              child: Image(image: AssetImage(profile)),
            ),
            const SizedBox(height: 50),
            Form(
                child: Column(
              children: [
                //*Username
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    label: Text('Username'),
                  ),
                ),
                const SizedBox(height: 20),
                //*Full Name
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    label: Text('Full Name'),
                  ),
                ),
                const SizedBox(height: 20),
                //*EmailAddress
                TextFormField(
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
        ),
      )),
    );
  }
}
