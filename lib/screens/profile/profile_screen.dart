import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/profile_controller.dart';
import 'package:tmwes/models/user_model.dart';
import 'package:tmwes/screens/faq/faq_screen.dart';
import 'package:tmwes/screens/profile/edit_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/image.dart';
import 'widgets/menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileController.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    return Column(children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(image: AssetImage(profile)),
                      ),
                      Text(userData.username,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 5),
                      Text(userData.email,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(text: 'Date Joined: ', children: [
                          TextSpan(
                              text: formatDate(userData.dateJoined),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                      ),
                    ]);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const EditProfileScreen()),
                    child: const Text('Edit Profile')),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      controller.resetPwd();
                      controller.resetPwdDialog();
                    },
                    child: const Text('Change password')),
              ),
            ]),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),

            //MENU
            MenuWidget(
                title: "Migraine Report",
                icon: Icons.fact_check_outlined,
                onPress: () {
                  controller.reportTimeRangeDialog();
                }),
            MenuWidget(
                title: "Contact Us",
                icon: Icons.feedback_outlined,
                onPress: () async {
                  final Uri url =
                      Uri.parse("mailto:1181203140@student.mmu.edu.my");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
            MenuWidget(
                title: "FAQ",
                icon: Icons.question_answer_outlined,
                onPress: () {
                  Get.to(() => const FaqScreen());
                }),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            MenuWidget(
                title: "Terms of Use",
                icon: Icons.privacy_tip_outlined,
                onPress: () {
                  controller.termsOfUseDialog();
                }),
            MenuWidget(
                title: "Logout",
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  controller.confirmLogoutDialog();
                }),
          ]),
        ),
      ),
    );
  }
}
