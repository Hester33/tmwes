//import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String fullName;
  final DateTime dateOfBirth;
  final String email;
  final String phoneNumber;
  final DateTime? dateJoined;
  //! Name, DOB/age, Gender, Email, Phone no, Pwd, CPwd

  UserModel({
    this.id,
    required this.username,
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.phoneNumber,
    this.dateJoined,
  });

  toJson() {
    return {
      "id": id,
      "username": username,
      "fullname": fullName,
      "dob": dateOfBirth,
      "email": email,
      "phone_no": phoneNumber,
      "date_joined": dateJoined,
    };
  }

  //*Map user from Firebase to UserModel
  // .fromSnapshot = named constrcutor
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return UserModel(
        id: data!["id"],
        username: data["username"],
        fullName: data["fullname"],
        dateOfBirth: data["dob"],
        email: data["email"],
        phoneNumber: data["phone_no"],
        dateJoined: data["date_joined"]);
  }
}
// Future<String> encrypt() async {
  //   String pwd = password;
  //   final String encryptedText = BCrypt.hashpw(
  //     pwd,
  //     BCrypt.gensalt(),
  //   );
  //   return encryptedText;
  // }

  // Future<bool> checkencryptText() async {
  //   final bool checkPassword = BCrypt.checkpw(
  //     password,
  //     encrypt() as String,
  //   );
  //   return checkPassword;
  // }