import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/screens/profile/edit_profile_screen.dart';

import '../../constants/image.dart';
import 'widgets/menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text('Profile', style: Theme.of(context).textTheme.displayLarge),
        // actions: [
        //   IconButton(onPressed: () {}, icon: icon)
        // ],
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
              const SizedBox(height: 10),
              Text('Name', style: Theme.of(context).textTheme.headlineMedium),
              Text('email@gmail.com',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const EditProfileScreen()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('Edit Profile',
                        style: TextStyle(color: Colors.black))),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //MENU
              MenuWidget(
                  title: "FAQ",
                  icon: Icons.chat_bubble_outline_outlined,
                  onPress: () {}),
              MenuWidget(
                  title: "FAQ",
                  icon: Icons.chat_bubble_outline_outlined,
                  onPress: () {}),
              MenuWidget(
                  title: "FAQ",
                  icon: Icons.chat_bubble_outline_outlined,
                  onPress: () {}),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              MenuWidget(
                  title: "FAQ",
                  icon: Icons.chat_bubble_outline_outlined,
                  onPress: () {}),
              MenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
