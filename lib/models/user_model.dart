import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String username;
  final String fullName;
  final String email;
  final String password;

  UserModel({
    this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
  });

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

  toJson() {
    return {
      "id": id,
      "username": username,
      "fullname": fullName,
      "email": email,
      "password": password,
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
        email: data["email"],
        password: data["password"]);
  }
}
