import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/screens/hit6/result_screen.dart';

class HIT6Screen extends StatelessWidget {
  const HIT6Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;
    int questionIndex;
    int ansIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HIT-6'),
        //! add submit btn
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index]['questionText'].toString();

              return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}: $question',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
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
                                        //!change style (for pressed button)
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: controller
                                                  .isSelected(
                                                      index, answerIndex)
                                              ? primaryColor.withOpacity(0.8)
                                              : Colors.blue.shade200,
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
                                              index, //!test
                                              questions,
                                              answers,
                                              answer['ansIndex']);
                                        },
                                        child: controller.isSelected(
                                                index, answerIndex)
                                            ? Text(answerText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge)
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
                                    ElevatedButton(
                                      onPressed: () {
                                        int score =
                                            controller.calculateScore(answers);
                                        //!check score
                                        print('Score: $score');
                                      },
                                      child: const Text("Submit"),
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
