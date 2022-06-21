import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String uid;
  String userName;
  String profilePhoto;
  String videoId;
  String videoUrl;
  String thumbnail;
  String caption;
  String songName;
  List likes;
  int comments;
  int shares;

  VideoModel({
    required this.uid,
    required this.userName,
    required this.profilePhoto,
    required this.videoId,
    required this.videoUrl,
    required this.thumbnail,
    required this.caption,
    required this.songName,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'profilePhoto': profilePhoto,
      'videoId': videoId,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'caption': caption,
      'songName': songName,
      'likes': likes,
      'comments': comments,
      'shares': shares,
    };
  }

  static VideoModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return VideoModel(
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      profilePhoto: snapshot['profilePhoto'],
      videoId: snapshot['videoId'],
      videoUrl: snapshot['videoUrl'],
      thumbnail: snapshot['thumbnail'],
      caption: snapshot['caption'],
      songName: snapshot['songName'],
      likes: snapshot['likes'],
      comments: snapshot['comments'],
      shares: snapshot['shares'],
    );
  }
}
