import 'package:get/get.dart';

import '../constants/text.dart';

class HIT6Controller extends GetxController {
  static HIT6Controller get instance => Get.find();

  var selectedAns = false.obs; //*for db
  var questionIndex = 0.obs;
  var totalScore = 0.obs;
  var selectedAnswerIndices = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the selectedAnswers list with the capacity of questions length
    selectedAnswerIndices.value = List<int>.filled(questions.length, -1);
  }

  bool isSelected(int questionIndex, int answerIndex) {
    return selectedAnswerIndices[questionIndex] == answerIndex;
  }

  answerQuestion(int score, index, List<Map<String, dynamic>> questions,
      answers, Object? answer) {
    //!assign answer index to question
    selectedAnswerIndices[index] = answer as int;
    //?selectedAns.value = index;
    print('AnswerInC: $answer');
    // Update the selected answer for the current question
    questions[index]['selectedAnswerScore'] = score;

//!check if the questions have save the answer
    print('questions Object: $questions');

    // Add the score of the selected answer to the total score
    totalScore.value += score;

    // ignore: avoid_print
    print('$questionIndex, score: $score, total: $totalScore');
    //!maybe should pass it back to the screen

    for (int i = 0; i < answers.length; i++) {
      if (answers[i]['ansIndex'] == answer) {
        answers[i]['selected'] = answer;
      } else {
        answers[i]['selected'] = -1;
      }
    }
  }

  // int calculateScore(List<Map<String, dynamic>> questions, answers) {
  //   int totalScore = 0;
  //   int index = 0; //not sure

  //   for (int i = 0; i < questions.length; i++) {
  //     //int answerIndex = selectedAnswers[i];
  //     //int score = questions[i]['answers'][answerIndex]['score'];
  //     totalScore += questions[i]['selectedAnswerScore'] as int;
  //     print('total score: $totalScore');
  //   }
  //   //!checking total score
  //   return totalScore;
  // }
  int calculateScore(List<Map<String, dynamic>> answers) {
    int totalScore = 0;
    List<int> scores = [];
    int score = 0;

    for (int i = 0; i < selectedAnswerIndices.length; i++) {
      final answerIndex = selectedAnswerIndices[i];
      score = 0;
      for (int j = 0; j < answers.length; j++) {
        if (answerIndex != -1 && answers[j]['ansIndex'] == answerIndex) {
          score = answers[j]['score'] as int;
        }
      }
      totalScore += score;
    }
    //   !checking total score
    print('Total Score: $totalScore');
    return totalScore;
  }

  void resetTest() {
    questionIndex.value = 0;
    totalScore.value = 0;
    print("reset! $questionIndex, total: $totalScore");
  }
}
