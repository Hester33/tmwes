import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  const AnswerWidget(this.selectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        onPressed: selectHandler(),
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        child: Text(answerText),
      ),
    );
  }
}
