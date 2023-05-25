import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/home_controller.dart';

class MigraineRiskWidget extends StatelessWidget {
  const MigraineRiskWidget({super.key});

  //!reference
  // if (snapshot.hasError) {
  //         return const Text('Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Text("Loading");
  //       }

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
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
                  child: Obx(
                    () => Container(
                      //height: 30,
                      padding: const EdgeInsets.all(4),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: migraineRiskColour(controller.pScore.value),
                      ),
                      child: Column(
                        children: [
                          const Text("Previous Migraine Risk: ",
                              textAlign: TextAlign.center),
                          //!pass the function here
                          Text(
                            calcMigraineRisk(controller.pScore.value),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(4),
                      //height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: migraineRiskColour(controller.cScore.value),
                      ),
                      child: Column(
                        children: [
                          const Text("Current Migraine Risk: ",
                              textAlign: TextAlign.center),
                          Text(
                            calcMigraineRisk(controller.cScore.value),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Flexible(
                //   flex: 1,
                //   fit: FlexFit.tight,
                //   child: ElevatedButton(
                //     onPressed: () => controller.migraineRiskData(),
                //     child: const Text("Migraine Risk: ",
                //         textAlign: TextAlign.center),
                //   ),
                // ),
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
