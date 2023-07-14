import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/home_controller.dart';

class MigraineRiskWidget extends StatelessWidget {
  const MigraineRiskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height:
          screenHeight * 0.085, // Adjust the height based on the screen size
      child: Column(children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: migraineRiskColour(controller.pScore.value),
                  ),
                  child: Column(children: [
                    const Text(
                      "Previous Migraine Risk: ",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      calcMigraineRisk(controller.pScore.value),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: migraineRiskColour(controller.cScore.value),
                  ),
                  child: Column(children: [
                    const Text(
                      "Current Migraine Risk: ",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      calcMigraineRisk(controller.cScore.value),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
