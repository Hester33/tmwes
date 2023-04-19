import 'package:get/get.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'package:tmwes/database/user_db.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  // final AuthenticationDb _authDb = Get.find();
  final _authDb = Get.put(AuthenticationDb());
  final _userDb = Get.put(UserDb());

  //Get user's id and pass to userDb for fetch user data
  getUserData() {
    final id = _authDb.firebaseUser.value?.uid;
    if (id != null) {
      return _userDb.getUserDetails(id);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }
}
