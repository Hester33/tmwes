import 'package:bcrypt/bcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'package:tmwes/screens/profile/edit_profile_screen.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;
    var isHover = false.obs;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.yellow.shade700,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          elevation: 0,
          // shape: BeveledRectangleBorder(
          //     // borderRadius: BorderRadius.circular(20.0),
          //     // side: BorderSide(color: Colors.blue, width: 2.0, style: BorderStyle.solid)
          //     ),
          // mini: true,
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5.0,
          shape: CircularNotchedRectangle(),
          color: Colors.black87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              //Ink(
              Padding(
                //color: Colors.transparent,
                padding: const EdgeInsets.only(left: 10.0),
                child: InkWell(
                  onTap: () async {
                    isHover.value = true;
                    print(isHover.value);
                    await Get.to(() => const ProfileScreen())
                        ?.then((value) => isHover.value = false);
                  },
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home,
                          //!test
                          color: isHover.value ? Colors.amber : Colors.white,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: isHover.value ? Colors.amber : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
                child: InkWell(
                  //onTap: () => Get.to(() => const ProfileScreen()),
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      Text(
                        "Shop",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              //! Add InkWell ink
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                child: InkWell(
                  onTap: () => Get.to(() => const ProfileScreen()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      Text(
                        "Fav",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: () => Get.to(() => const ProfileScreen()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      Text(
                        "Setting",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                              // final bool checkPassword =
                              //     BCrypt.checkpw(password, encrypt);
                              Get.to(() => const ProfileScreen());
                            },
                            icon: const Icon(Icons.location_on_sharp)),
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
      ),
    );
  }
}
