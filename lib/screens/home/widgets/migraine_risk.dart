import 'package:flutter/material.dart';

class MigraineRiskWidget extends StatelessWidget {
  const MigraineRiskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return
    // FutureBuilder(
    //       //the getUserData() function will store the data in future
    //       future: controller.getUserData(),
    //       builder: (context, snapshot) {
    //         //if data is completely fetched
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           if (snapshot.hasData) {
    //             //map snapshot data to UserModel
    //             UserModel userData = snapshot.data as UserModel;

    //             //Controllers
    //             final username = TextEditingController(text: userData.username);
    //             final fullName = TextEditingController(text: userData.fullName);
    //             // final dob = TextEditingController(
    //             //         text: controller.formatDate(userData.dateOfBirth))
    //             //     .obs; //!obs??
    //             signUpController.dob.value.text =
    //                 controller.formatDate(userData.dateOfBirth);
    //             final email = TextEditingController(text: userData.email);
    //             final phoneNo =
    //                 TextEditingController(text: userData.phoneNumber);

    //             var isPwdHidden = true.obs;
    //             var isCPwdHidden = true.obs;

    return Container(
      height: 60,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: const Text("Previous Migraine Risk: ",
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: const Text("Current Migraine Risk: ",
                        textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    //   }
    // );
  }
}
