import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/exceptions/signup_failure.dart';
import 'package:tmwes/screens/home/home.dart';
import 'package:tmwes/screens/welcome/welcome_screen.dart';

class AuthenticationDb extends GetxController {
  static AuthenticationDb get instance => Get.find();

  //Variables
  //firebase authentication instance
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

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
        : Get.offAll(() => const Home());
  }

  Future<void> createUserWithEmailAndPwd(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //!=null
      firebaseUser.value == null
          ? Get.offAll(() => const WelcomeScreen())
          : Get.offAll(() => const Home());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Error", ex.msg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print('FIREBASE AUTH EXPECTION - ${ex.msg}, ${e.code}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.msg}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPwd(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value == null
          ? Get.offAll(() => const WelcomeScreen())
          : Get.offAll(() => const Home());
    } on FirebaseAuthException catch (e) {
      //! Create exception
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
      throw ex;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
