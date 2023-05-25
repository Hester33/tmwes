import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//!add Rx type
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
// User? currentUser = auth.currentUser;
//Rx<User?> currentUser = Rx<User?>(auth.currentUser);

//add you country utc here
//UTC+8
const Duration utc = Duration(hours: 8);

//*collection
const usersCollection = "users";
const hit6Collection = "hit6";
