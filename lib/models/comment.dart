import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String uid;
  String username;
  String profilePhoto;
  String commentId;
  String comment;
  final datePublished;
  List likes;
  bool likedByMe;

  CommentModel({
    required this.uid,
    required this.username,
    required this.profilePhoto,
    required this.commentId,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.likedByMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'profilePhoto': profilePhoto,
      'commentId': commentId,
      'comment': comment,
      'datePublished': datePublished,
      'likes': likes,
      'likedByMe': likedByMe,
    };
  }

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      profilePhoto: snapshot['profilePhoto'],
      commentId: snapshot['commentId'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      likedByMe: snapshot['likedByMe'],
    );
  }
}
