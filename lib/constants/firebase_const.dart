import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//!add Rx type
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

//*collection
const usersCollection = "users";
const hit6Collection = "hit6";
const migraineRecordCollection = "records";
