//date, score, selectedans, userId
import 'package:cloud_firestore/cloud_firestore.dart';

class HIT6Model {
  final String? userId;
  final int score;
  final DateTime recordDate;
  final List<int> selectedAns;
  //final String? weather;

  HIT6Model({
    this.userId,
    required this.score,
    required this.recordDate,
    required this.selectedAns,
    //this.weather
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": userId,
      "score": score,
      "record_date": recordDate,
      "selected_ans": selectedAns,
      //"weather": weather,
    };
  }

//!refer this
  // weather: (json['weather'] as List<dynamic>?)
  //           ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  factory HIT6Model.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    //Map<String,dynamic>
    //String=key_name, dynamic=value
    final data = doc.data();
    Timestamp rDate = data!["record_date"] as Timestamp;
    return HIT6Model(
      userId: data["uid"],
      score: data["score"],
      recordDate: rDate.toDate(),
      selectedAns: List.from(data['selected_ans']),
      // data["selected_ans"] is Iterable
      //     ? List.from(data['selected_ans'])
      //     : null,
      //weather: data["weather"],
    );
  }
}
