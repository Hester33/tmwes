import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/screens/hit6/widgets/migraine_precautions.dart';
import 'package:tmwes/screens/home/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  const ResultScreen(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController.instance;
    final hit6Controller = HIT6Controller.instance;
    hit6Controller.getIndex(resultScore);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set a fixed height
          padding: const EdgeInsets.all(30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "${hit6Controller.totalScore.value}",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.apply(fontSizeDelta: 3),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "HIT-6 Score",
                      style: Theme.of(context).textTheme.headlineMedium?.apply(
                          fontSizeDelta: 1,
                          decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    clipBehavior: Clip.none,
                    itemCount: hit6Controller.resultMessages.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200),
                              color: index == hit6Controller.index.value
                                  ? migraineRiskColour(resultScore)
                                  : Colors.white,
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          "${hit6Controller.resultMessages[index]['scoreRange']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.apply(color: primaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        hit6Controller.resultMessages[index]
                                            ['message'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.apply(color: primaryColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          const SizedBox(height: 10)
                        ],
                      );
                    },
                  ),
                ),
                MigrainePrecautionsWidget(
                    score: hit6Controller.totalScore.value),
                SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      homeController.migraineRiskData();
                      // ignore: avoid_print
                      print(
                          "result screen total s:${hit6Controller.totalScore.value}");
                      Get.offAll(() => const HomeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(13),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
