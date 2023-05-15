import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final List<Map<String, dynamic>> questions, answers;

  ResultScreen(
      this.resultScore, this.resetHandler, this.questions, this.answers,
      {Key? key})
      : super(key: key);

  // Define a list of result messages and their corresponding score ranges
  final List<Map<String, dynamic>> resultMessages = [
    {'scoreRange': 41, 'message': 'You are awesome!'},
    {'scoreRange': 31, 'message': 'Pretty likeable!'},
    {'scoreRange': 21, 'message': 'You need to work more!'},
    {'scoreRange': 1, 'message': 'You need to work hard!'},
    {'scoreRange': 0, 'message': 'This is a poor score!'},
  ];

  //Get final score
  int get finalScore {
    return 0;
  }

  // Get the result message based on the result score
  String get resultPhrase {
    String resultText = '';
    for (int i = 0; i < resultMessages.length; i++) {
      if (resultScore >= (resultMessages[i]['scoreRange'] as int)) {
        resultText = resultMessages[i]['message'] as String;
        break;
      }
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Score: $resultScore',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () => resetHandler(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.all(14),
            ),
            child: const Text(
              'Restart Quiz',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
// In this improved version of the Result widget:

// The result messages and their corresponding score ranges are defined using a list of maps (resultMessages).
// The resultPhrase getter method iterates through the resultMessages list to determine the appropriate result message based on the result score.
// The result message and score are displayed using Text widgets.
// The restart button is displayed using an ElevatedButton widget, with updated styling using ElevatedButton.styleFrom to set the button color and padding.
// These improvements make the Result page more flexible and maintainable by easily adding or modifying the result messages and their score ranges in the future.






