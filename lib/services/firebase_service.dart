// creating firebaseService class
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
//creating a variable called firebase Auth

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseStorage _db = FirebaseStorage.instance;
  FirebaseFirestore _storage = FirebaseFirestore.instance;

// creating FirebaseService constructor

  FirebaseService();
}
