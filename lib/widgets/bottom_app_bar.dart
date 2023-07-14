// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tmwes/screens/hit6/hit6_record_screen.dart';
// import 'package:tmwes/screens/hit6/hit6_screen.dart';
// import 'package:tmwes/screens/home/home_screen.dart';
// import 'package:tmwes/screens/profile/profile_screen.dart';

// import '../constants/colors.dart';

// class BottomAppBarWidget extends StatelessWidget {
//   const BottomAppBarWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       notchMargin: 5.0,
//       shape: const CircularNotchedRectangle(),
//       color: primaryColor,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           //Ink(
//           Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: InkWell(
//               onTap: () async {
//                 await Get.to(() => const HomeScreen());
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.home,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Home",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
//             child: InkWell(
//               onTap: () {
//                 Get.to(() => const HIT6Screen());
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.list_alt_outlined,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "HIT-6",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
//             child: InkWell(
//               onTap: () {
//                 Get.to(() => const HIT6RecordScreen());
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.leaderboard_rounded,
//                     //* library_books
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Record",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: InkWell(
//               onTap: () => Get.to(() => const ProfileScreen()),
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.manage_accounts,
//                     //* miscellaneous_services, more_horiz_outlined, account_circle
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "More",
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/screens/hit6/hit6_record_screen.dart';
import 'package:tmwes/screens/hit6/hit6_screen.dart';
import 'package:tmwes/screens/home/home_screen.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';

import '../constants/colors.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BottomAppBar(
      notchMargin: screenWidth *
          0.0125, // Adjust the notch margin based on the screen size
      shape: const CircularNotchedRectangle(),
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth *
                    0.025), // Adjust the padding based on the screen size
            child: InkWell(
              onTap: () async {
                await Get.to(() => const HomeScreen());
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: screenWidth * 0.1,
                top: screenWidth * 0.025,
                bottom: screenWidth *
                    0.025), // Adjust the padding based on the screen size
            child: InkWell(
              onTap: () {
                Get.to(() => const HIT6Screen());
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
            padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                top: screenWidth * 0.025,
                bottom: screenWidth *
                    0.025), // Adjust the padding based on the screen size
            child: InkWell(
              onTap: () {
                Get.to(() => const HIT6RecordScreen());
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.leaderboard_rounded,
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
            padding: EdgeInsets.only(
                right: screenWidth *
                    0.025), // Adjust the padding based on the screen size
            child: InkWell(
              onTap: () => Get.to(() => const ProfileScreen()),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.manage_accounts,
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
