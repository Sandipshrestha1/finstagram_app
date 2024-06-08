// import 'dart:io';
// import 'package:path/path.dart' as p;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// final String USER_COLLECTION = 'users';
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// class FirebaseService {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseStorage _db = FirebaseStorage.instance;
//   FirebaseFirestore _storage = FirebaseFirestore.instance;
//   Map? currentUser;
//   FirebaseService();
//   Future<bool> registerUser({
//     required String name,
//     required String email,
//     required String password,
//     required File image,
//   }) async {
//     try {
//       UserCredential _userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       String _userId = _userCredential.user!.uid;
//       String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
//           p.extension(image.path);
//       UploadTask _task =
//           _storage.ref('images/$_userId/$_fileName').putFile(image);
//       return _task.then((_snapshot) async {
//         String _downloadURL = await _snapshot.ref.getDownloadURL();
//         await _db.collection(USER_COLLECTION).doc(userId).set({
//           "name": name,
//           "email": email,
//           "image": _downloadURL,
//         });
//       });       //UploadTask _task =
//   _storage.ref('images/$_userId/$_fileName').putFile(image);
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//   Future<bool> loginUser(
//       {required String email, required String password}) async {
//     try {
//       UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       currentUser = await getUserData(uid: _userCredential.user!.uid);
//       if (_userCredential.user != null) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//   Future<Map> getUserData({required String uid}) async {
//     DocumentSnapshot _doc =
//         await _firestore.collection(USER_COLLECTION).doc(uid).get();
//     return _doc.data() as Map;
//   }
// }
// creating firebaseService class
// ignore_for_file: unused_field
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String USER_COLLECTION = 'users';
final String POSTS_COLLECTION = 'posts';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirebaseService {
  // creating a variable called firebase Auth
  FirebaseAuth _auth = FirebaseAuth.instance;
  // Correcting the storage instance
  FirebaseStorage _db = FirebaseStorage.instance;
  // Correcting the firestore instance
  // FirebaseFirestore _storage = FirebaseFirestore.instance;
  // creating FirebaseService constructor
  Map? currentUser;
  FirebaseService();
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String _userId = _userCredential.user!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      // Correcting storage instance and removing redundant assignment
      UploadTask _task = _db.ref('images/$_userId/$_fileName').putFile(image);
      return _task.then((_snapshot) async {
        String _downloadURL = await _snapshot.ref.getDownloadURL();
        await _firestore.collection(USER_COLLECTION).doc(_userId).set({
          //await _db.collection(USER_COLLECTION).doc(_userId).set({
          "name": name,
          "email": email,
          "image": _downloadURL,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser = await getUserData(uid: _userCredential.user!.uid);
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

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _firestore.collection(USER_COLLECTION).doc(uid).get();
    // Adding await to ensure data is retrieved
    return await _doc.data() as Map;
  }

  Future<bool> postImage(File _image) async {
    try {
      String _userId = _auth.currentUser!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(_image.path);

      UploadTask _task = _db.ref('images/$_userId/$_fileName').putFile(_image);

      return await _task.then((_snapshot) async {
        String _downloadURL = await _snapshot.ref.getDownloadURL();

        await _firestore.collection(POSTS_COLLECTION).add({
          "userId": _userId,
          "timestamp": Timestamp.now(),
          "image": _downloadURL,
        });

        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getPostsForUser() {
    String _userId = _auth.currentUser!.uid;
    return _firestore
        .collection(POSTS_COLLECTION)
        .where('userId', isEqualTo: _userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _firestore
        .collection(POSTS_COLLECTION)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
