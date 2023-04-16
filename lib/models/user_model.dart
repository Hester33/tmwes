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

  toJson() {
    return {
      "username": username,
      "fullname": fullName,
      "email": email,
      "password": password,
    };
  }
}
