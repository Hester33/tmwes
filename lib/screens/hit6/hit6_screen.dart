import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/screens/hit6/hit6_result_screen.dart';

class HIT6Screen extends StatelessWidget {
  const HIT6Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;
    int questionIndex;
    int ansIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text('HIT-6',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.apply(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index]['questionText'].toString();

              return Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Question ${index + 1}:\n$question',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Wrap(
                            spacing: 15,
                            //runSpacing: 10,
                            direction: Axis.vertical,
                            children: answers.map((answer) {
                              final answerText = answer['text'].toString();
                              final score = answer['score'] as int;
                              final answerIndex = answer['ansIndex'] as int;

                              return SizedBox(
                                  width: 250,
                                  child: Obx(() => ElevatedButton(
                                        //change style for pressed button
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: controller
                                                  .isSelected(
                                                      index, answerIndex)
                                              ? primaryColor.withOpacity(0.8)
                                              : Colors.blue.shade100,
                                        ),
                                        onPressed: () {
                                          //!test
                                          questionIndex = questions[index]
                                              ['questionIndex'] as int;
                                          print(
                                              'AnsIndex: ${answer['ansIndex']}');
                                          // controller.selectedAns.value =
                                          //     !controller.selectedAns.value;
                                          controller.answerQuestion(
                                              score,
                                              index,
                                              questions,
                                              answers,
                                              answer['ansIndex']);
                                        },
                                        child: controller.isSelected(
                                                index, answerIndex)
                                            ? Text(answerText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.apply(
                                                        color: Colors.white))
                                            : Text(answerText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .apply(
                                                        color: Colors.black)),
                                      )));
                            }).toList(),
                          ),
                        ),
                        Center(
                          child: index == questions.length - 1
                              ? Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: 130,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          int score = controller
                                              .calculateScore(answers);
                                          //!check score
                                          print('Score: $score');
                                          controller.storeRecord();
                                          Get.off(() => ResultScreen(
                                              score, controller.resetTest));
                                        },
                                        child: const Text("Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        )
                      ]));
            },
          ),
        ),
      ]),
    );
  }
}
