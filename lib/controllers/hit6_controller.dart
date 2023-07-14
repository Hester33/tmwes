import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/models/hit6_model.dart';
import 'package:tmwes/services/hit6_db.dart';

import '../constants/text.dart';

class HIT6Controller extends GetxController {
  static HIT6Controller get instance => Get.find();

  final hit6Db = HIT6Db.instance;

  var selectedAns = false.obs; //*for db
  var questionIndex = 0.obs;
  var totalScore = 0.obs;
  var selectedAnswerIndices = <int>[].obs;
  var index = 0.obs;

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
    //assign answer index to question
    selectedAnswerIndices[index] = answer as int;

    // ignore: avoid_print
    print('$questionIndex, score: $score');
  }

  Future<void> storeRecord() async {
    hit6Db.storeHIT6(totalScore.value, selectedAnswerIndices.toList());
  }

  Future<List<HIT6Model>> getAllRecords() async {
    return await hit6Db.getAllHIT6Records();
  }

  getHit6Record(DateTime recordDate) async {
    return await hit6Db.getHIT6Record(recordDate);
  }

  int calculateScore(List<Map<String, dynamic>> answers) {
    int score = 0;

    for (int i = 0; i < selectedAnswerIndices.length; i++) {
      final answerIndex = selectedAnswerIndices[i];
      score = 0;
      for (int j = 0; j < answers.length; j++) {
        if (answerIndex != -1 && answers[j]['ansIndex'] == answerIndex) {
          score = answers[j]['score'] as int;
        }
      }
      // Add the score of the selected answer to the total score
      totalScore.value += score;
    }
    return totalScore.value;
  }

  void resetTest() {
    totalScore.value = 0;
  }

//*-----HIT-6 Result-----*//
  List<String> getMigrainePrecautions(int score) {
    if (score >= 60) {
      return severeMigraine;
    } else if (score > 55 && totalScore.value < 60) {
      return severeMigraine;
    } else if (score >= 50 && totalScore.value <= 55) {
      return moderateMigraine;
    } else {
      return lowLvlMigraine;
    }
  }

  // Define a list of result messages and their corresponding score ranges
  final List<Map<String, dynamic>> resultMessages = [
    {'score': 59, 'scoreRange': "60 - 78", 'message': 'Severe impact'},
    {'score': 55, 'scoreRange': "56 - 59", 'message': 'Substantial impact'},
    {'score': 49, 'scoreRange': "50 - 55", 'message': 'Some impact'},
    {'score': 0, 'scoreRange': "0 - 49", 'message': 'Little or no impact'},
  ];

  // Get the result message based on the result score
  void getIndex(score) {
    for (int i = 0; i < resultMessages.length; i++) {
      // check score
      if (score >= (resultMessages[i]['score'] as int)) {
        index.value = i;
        return;
      }
    }
  }

  //*-----HIT-6 Record-----*//
  scoreColour(int value) {
    if (value > 55) {
      return Colors.redAccent;
    } else if (value >= 50 && value <= 55) {
      return Colors.orangeAccent;
    } else if (value <= 49) {
      return Colors.greenAccent;
    } else {
      return Colors.grey[200];
    }
  }

  getMigraineImpactMessage(int score) {
    String message = 'No message found';
    for (var result in resultMessages) {
      if (score >= result['score']) {
        message = result['message'];
        break;
      }
    }
    return message;
  }
}
