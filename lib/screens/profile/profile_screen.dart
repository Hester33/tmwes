import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/controllers/profile_controller.dart';
import 'package:tmwes/screens/profile/edit_profile_screen.dart';
import 'package:tmwes/screens/welcome/welcome_screen.dart';

import '../../constants/image.dart';
import 'widgets/menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Get.back();
        //     },
        //     icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text('Profile', style: TextStyle(fontSize: 26)),
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
                width: 100,
                height: 100,
                //child: ClipRRect(borderRadius: BorderRadius.circular(100), child: Image(image: AssetImage(profile))),
                child: Image(image: AssetImage(profile)),
              ),
              const SizedBox(height: 10),
              Text('Name', style: Theme.of(context).textTheme.headlineMedium),
              Text('email@gmail.com',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    //width: 200,
                    child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const EditProfileScreen()),
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: primaryColor,
                        //     side: BorderSide.none,
                        //     shape: const StadiumBorder(),),
                        child: const Text('Edit Profile')),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    //width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          ProfileController.instance.resetPwd();
                          Get.defaultDialog(
                            title: "Email sent!",
                            middleText:
                                "Please check your email to change the password.",
                            //backgroundColor: Colors.green,
                            titleStyle: TextStyle(color: Colors.green),
                            middleTextStyle: TextStyle(color: Colors.blueGrey),
                            textConfirm: "Ok",
                            confirmTextColor: Colors.white,
                            onConfirm: () =>
                                Get.to(() => const WelcomeScreen()),
                            //buttonColor: Colors.red,
                            barrierDismissible: false,
                            //radius: 50,
                            // content: Column(
                            //   children: [
                            //     Container(child: Text("Hello 1")),
                            //     Container(child: Text("Hello 2")),
                            //     Container(child: Text("Hello 3")),
                            //   ],
                            //)
                          );
                        },
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: primaryColor,
                        //     side: BorderSide.none,
                        //     shape: const StadiumBorder()),
                        child: const Text('Change password')),
                  ),
                ],
              ),

              //! 1. Create change pwd button
              //! 2. Once user click on it, snow snackbar/dialog box & wait for 1s then LOGOUT
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),

              //MENU
              MenuWidget(
                  title: "Personal Details",
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
