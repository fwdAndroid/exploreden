import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String uid;
  String email;
  String firstName;
  String lastName;
  String photoURL;
  String phoneNumber;

  ProfileModel(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.photoURL,
      required this.phoneNumber,
      required this.lastName});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'phoneNumber': phoneNumber,
        'photoURL': photoURL
      };

  ///
  static ProfileModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProfileModel(
      lastName: snapshot['lastName'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoURL: snapshot['photoURL'],
      firstName: snapshot['firstName'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }
}
