//date, score, selectedans, userId
import 'package:cloud_firestore/cloud_firestore.dart';

class MigraineRecordModel {
  final String? userId;
  final DateTime mRecordDate;
  final String painLevel;
  final List<String>? painPosition;
  final List<String>? triggers;
  final List<String>? medicine;
  //final String? weather;

//! Add weather variables
  MigraineRecordModel({
    this.userId,
    required this.mRecordDate,
    required this.painLevel,
    required this.painPosition,
    required this.triggers,
    required this.medicine,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": userId,
      //!checking the date
      "record_date": Timestamp.fromDate(mRecordDate),
      "pain_level": painLevel,
      "pain_position": painPosition,
      "triggers": triggers,
      "medicine": medicine,
      //"weather": weather,
    };
  }

  factory MigraineRecordModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    //Map<String,dynamic>
    //String=key_name, dynamic=value
    final data = doc.data();
    Timestamp rDate = data!["record_date"] as Timestamp;
    return MigraineRecordModel(
      userId: data["uid"],
      mRecordDate: rDate.toDate(),
      painLevel: data['pain_level'],
      painPosition: List.from(data['pain_position']),
      triggers: List.from(data['triggers']),
      medicine:
          data["medicine"] is Iterable ? List.from(data['medicine']) : null,
    );
  }
}
