import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/exceptions/exceptions.dart';
import 'package:tmwes/helpers/loading.dart';
import 'package:tmwes/screens/home/home_screen.dart';
import 'package:tmwes/screens/welcome/welcome_screen.dart';

class AuthenticationDb extends GetxController {
  static AuthenticationDb get instance => Get.find();

  //Variables
  //firebase authentication instance
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  var userName = ''.obs;

  //@override
  // void onInit() {
  //   userName = RxString(userProfile != null ? userProfile!.displayName! : '');
  //   super.onInit();
  // }

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    //userChange() = always listen to the user state
    //inform firebaseUser to do some action
    firebaseUser.bindStream(_auth.userChanges());
    //action
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const HomeScreen());
  }

  Future<String?> createUserWithEmailAndPwd(
      String email, String password, String username) async {
    try {
      //showLoading();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => userName.value = username);
      firebaseUser.value!.updateDisplayName(userName.value);

      //!=null
      firebaseUser.value == null
          ? Get.offAll(() => const WelcomeScreen())
          : Get.offAll(() => const HomeScreen());
      return firebaseUser.value!.uid;
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.msg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print('FIREBASE AUTH EXPECTION - ${ex.msg}, ${e.code}');
      //throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.msg}');
      throw ex.msg;
    }
    return null;
  }

//Verify the user's email
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      throw ex.msg;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      throw ex.msg;
    }
  }

  Future<void> loginUserWithEmailAndPwd(String email, String password) async {
    try {
      showLoading();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => userName.value = firebaseUser.value!.displayName!);
      firebaseUser.value == null
          ? Get.offAll(() => const WelcomeScreen())
          : Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      //! Create exception
      final ex = LoginWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.msg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print('FIREBASE AUTH EXPECTION - ${ex.msg}, ${e.code}');
      //throw ex;
    } catch (_) {
      const ex = LoginWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.msg}');
      throw ex;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    }
    //.catchError((e) => print('FIREBASE AUTH EXPECTION -  ${e.code}'));
    on FirebaseAuthException catch (e) {
      //! Create exception
      final ex = LoginWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.msg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print('FIREBASE AUTH EXPECTION - ${ex.msg}, ${e.code}');
      //throw ex;
    } catch (_) {
      const ex = LoginWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.msg}');
      throw ex;
    }
  }
}
