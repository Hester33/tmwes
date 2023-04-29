import 'package:bcrypt/bcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';
import 'package:tmwes/widgets/bottom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    var isHover = false.obs;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.yellow.shade700,

        // appBar: AppBar(
        //   title: Text('Hi, Hester!\nHow are you feeling today?'),
        //   elevation: 0,
        //   //backgroundColor: Colors.transparent,
        //   actions: [
        //     // Row(
        //     //   children: [
        //     //     Container(
        //     //       margin: const EdgeInsets.only(right: 20, top: 7),
        //     //       decoration: BoxDecoration(
        //     //           borderRadius: BorderRadius.circular(10),
        //     //           color: Color(0xffe0e0e0)),
        //     //       child: IconButton(
        //     //         onPressed: () {},
        //     //         icon: Icon(Icons.home),
        //     //       ),
        //     //     )
        //     //   ],
        //     // )
        //     IconButton(
        //         onPressed: () {}, icon: const Icon(Icons.location_on_sharp)),
        //     IconButton(
        //         onPressed: () {}, icon: const Icon(Icons.location_on_sharp)),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Obx(
                    //   () =>
                    Column(
                      children: [
                        Text(
                          'Hi ${user?.displayName.toString()},\nHow are you feeling today?',
                          textAlign: TextAlign.left,
                        ),
                        //Text('How are you feeling today?'),
                      ],
                    ),
                    //),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              AuthenticationDb.instance.logout();
                            },
                            icon: const Icon(Icons.calendar_month_outlined)),
                        IconButton(
                            onPressed: () {
                              Get.to(() => const ProfileScreen());
                            },
                            icon: const Icon(
                                Icons.location_on_sharp)), //*fmd_good
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 800,
                color: Colors.amber,
              ),
              Container(
                height: 800,
                color: Colors.blue,
              )
            ],
          ),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: bottomAppBarWidget(isHover: isHover),
      ),
    );
  }
}
