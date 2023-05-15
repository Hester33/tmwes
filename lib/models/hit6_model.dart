//date, score, selectedans, userId
import 'package:cloud_firestore/cloud_firestore.dart';

class HIT6Model {
  final String? userId;
  final int score;
  final DateTime recordDate;
  final List<int>? selectedAns;

  HIT6Model(
      {this.userId,
      required this.score,
      required this.recordDate,
      this.selectedAns});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "score": score,
      "record_date": recordDate,
      "selected_ans": selectedAns,
    };
  }

//!refer this
  // weather: (json['weather'] as List<dynamic>?)
  //           ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  factory HIT6Model.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    //Map<String,dynamic>
    //String=key name, dynamic=value
    final data = doc.data();
    Timestamp rDate = data!["record_date"] as Timestamp;
    Timestamp dj = data["date_joined"] as Timestamp;
    return HIT6Model(
      userId: data["userId"],
      score: data["username"],
      recordDate: rDate.toDate(),
      selectedAns: data["selected_ans"] is Iterable
          ? List.from(data['selected_ans'])
          : null,
    );
  }
}
