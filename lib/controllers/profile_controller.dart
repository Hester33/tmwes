import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'package:tmwes/database/user_db.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authDb = AuthenticationDb.instance;
  final _userDb = UserDb.instance;

  // final _authDb = Get.put(AuthenticationDb());
  //final _userDb = Get.put(UserDb());

  //Get user's id and pass to userDb for fetch user data
  getUserData() {
    final id = _authDb.firebaseUser.value?.uid;
    if (id != null) {
      return _userDb.getUserDetails(id);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateUserDetails(UserModel user) async {
    await _userDb.updateUserDetails(user);
  }

  resetPwd() {
    final email = _authDb.firebaseUser.value?.email;
    _authDb.resetPassword(email!);
  }

  String formatDate(DateTime? dateJoined) {
    String formattedDate = DateFormat('d MMMM yyyy').format(dateJoined!);
    return formattedDate;
  }
}
