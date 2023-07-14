import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/models/hit6_model.dart';
import 'package:tmwes/screens/hit6/widgets/migraine_precautions.dart';

class HIT6RecordDetailsScreen extends StatelessWidget {
  final DateTime recordDate;
  const HIT6RecordDetailsScreen({super.key, required this.recordDate});

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        title: Text(
          'HIT-6 (${formatRecordDate(recordDate)})',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(children: [
          FutureBuilder(
            future: controller.getHit6Record(recordDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  HIT6Model hit6Record = snapshot.data as HIT6Model;
                  //get the message index
                  controller.getIndex(hit6Record.score);
                  //get selected answers
                  List<int> selectedAns = hit6Record.selectedAns;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question =
                            questions[index]['questionText'].toString();

                        return Column(children: [
                          Container(
                            child: index == 0
                                ? Column(children: [
                                    const SizedBox(height: 30),
                                    Text(
                                      hit6Record.score.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.apply(fontSizeDelta: 5),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "HIT-6 Score",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.apply(
                                              fontSizeDelta: 1,
                                              decoration:
                                                  TextDecoration.underline),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 30),

                                    //*Impact
                                    Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade200),
                                          color: migraineRiskColour(
                                              hit6Record.score)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(children: [
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: 80,
                                                child: Obx(
                                                  () => Text(
                                                    "${controller.resultMessages[controller.index.value]['scoreRange']}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.apply(
                                                            color:
                                                                primaryColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Text(
                                                controller.resultMessages[
                                                        controller.index.value]
                                                    ['message'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.apply(
                                                        color: primaryColor),
                                                textAlign: TextAlign.center,
                                              )
                                            ]),
                                          ]),
                                    ),
                                    const SizedBox(height: 20),

                                    //*Migraine Precaution
                                    MigrainePrecautionsWidget(
                                        score: hit6Record.score),
                                    const SizedBox(height: 25),

                                    //*HIT-6 Questions
                                    Text(
                                      "HIT-6 Questions:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.apply(
                                              color: primaryColor,
                                              fontSizeDelta: -3),
                                    ),
                                  ])
                                : null,
                          ),
                          Container(
                              width: 400,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueGrey.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white70),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Question ${index + 1}:\n$question',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.apply(fontSizeDelta: 1),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Answer: ${answers[selectedAns[index]]['text']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.apply(
                                                color: primaryColor,
                                                fontWeightDelta: 2),
                                      ),
                                    ),
                                  ])),
                        ]);
                      },
                    ),
                  );
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
        ]),
      ),
    );
  }
}
