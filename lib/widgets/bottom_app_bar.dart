import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/screens/home/home_screen.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';

import '../constants/colors.dart';

class bottomAppBarWidget extends StatelessWidget {
  const bottomAppBarWidget({
    super.key,
    required this.isHover,
  });

  final RxBool isHover;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5.0,
      shape: const CircularNotchedRectangle(),
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          //Ink(
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: InkWell(
              onTap: () async {
                isHover.value = true;
                print(isHover.value);
                await Get.to(() => const HomeScreen())
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
                    Icons.list_alt_outlined,
                    color: Colors.white,
                  ),
                  Text(
                    "HIT-6",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: InkWell(
              onTap: () => Get.to(() => const ProfileScreen()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.leaderboard_rounded,
                    //* library_books
                    color: Colors.white,
                  ),
                  Text(
                    "Record",
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
                children: const [
                  Icon(
                    Icons.manage_accounts,
                    //* miscellaneous_services, more_horiz_outlined, account_circle
                    color: Colors.white,
                  ),
                  Text(
                    "More",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// return Scaffold(
//       backgroundColor: Colors.yellow.shade700,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Floating Action Button",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.black45,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//         backgroundColor: Colors.black87,
//         foregroundColor: Colors.yellow,
//         elevation: 0,
//         // shape: BeveledRectangleBorder(
//         //     // borderRadius: BorderRadius.circular(20.0),
//         //     // side: BorderSide(color: Colors.blue, width: 2.0, style: BorderStyle.solid)
//         //     ),
//         // mini: true,
//       ),
//       bottomNavigationBar: BottomAppBar(
//         notchMargin: 5.0,
//         shape: CircularNotchedRectangle(),
//         color: Colors.black87,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.home,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Home",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.shopping_cart,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Shop",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.favorite,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Fav",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.settings,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Setting",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );