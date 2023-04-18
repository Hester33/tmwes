import 'package:bcrypt/bcrypt.dart';

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
      "username": username,
      "fullname": fullName,
      "email": email,
      "password": password,
    };
  }
}
