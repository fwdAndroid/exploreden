import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/models/profile_models.dart';
import 'package:exploreden/services/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future<String> profile(
      {required String firstname,
      required String lastname,
      required String phone,
      required Uint8List file}) async {
    String res = 'Some error occured';
    try {
      String photoURL = await StorageMethods()
          .uploadImageToStorage('ProfilePics', file, false);
      //Add User to the database with modal
      ProfileModel userModel = ProfileModel(
          firstName: firstname,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: FirebaseAuth.instance.currentUser!.email!,
          lastName: lastname,
          phoneNumber: phone,
          photoURL: photoURL);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toJson());
      res = 'sucess';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
