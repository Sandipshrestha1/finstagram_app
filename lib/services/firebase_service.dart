// creating firebaseService class
// ignore_for_file: unused_field

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

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
