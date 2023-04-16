import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

//!add Rx type
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
// User? currentUser = auth.currentUser;
//Rx<User?> currentUser = Rx<User?>(auth.currentUser);

//*collection
const usersCollection = "users";
