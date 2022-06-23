import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String profilePicture;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'profilePicture': profilePicture,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      profilePicture: snapshot['profilePicture'],
    );
  }
}
