import 'package:cloud_firestore/cloud_firestore.dart';

class RecordMigraineModel {
  final String? userId;
  final String? weather;
  final DateTime mRecordDate;
  final String startTime;
  final int? hour;
  final int? minutes;
  final String? painLevel;
  final List<String>? painPosition;
  final List<String>? triggers;
  final List<String>? medicine;

  RecordMigraineModel({
    this.userId,
    required this.weather,
    required this.mRecordDate,
    required this.startTime,
    required this.hour,
    required this.minutes,
    required this.painLevel,
    required this.painPosition,
    required this.triggers,
    required this.medicine,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": userId,
      "weather": weather,
      "record_date": Timestamp.fromDate(mRecordDate),
      "start_time": startTime,
      "hour": hour,
      "minutes": minutes,
      "pain_level": painLevel,
      "pain_position": painPosition,
      "triggers": triggers,
      "medicine": medicine,
    };
  }

  factory RecordMigraineModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    //Map<String,dynamic>
    //String=key_name, dynamic=value
    final data = doc.data();
    Timestamp rDate = data!["record_date"] as Timestamp;
    return RecordMigraineModel(
      userId: data!["uid"],
      weather: data["weather"],
      mRecordDate: rDate.toDate(),
      startTime: data["start_time"],
      hour: data["hour"],
      minutes: data["minutes"],
      painLevel: data['pain_level'],
      painPosition: List.from(data['pain_position']),
      triggers: List.from(data['triggers']),
      medicine:
          data["medicine"] is Iterable ? List.from(data['medicine']) : null,
    );
  }
}
