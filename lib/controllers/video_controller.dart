import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _videosList = Rx<List<VideoModel>>([]);

  List<VideoModel> get videosList => _videosList.value;

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();

    _videosList.bindStream(
      firebaseFirestore.collection('videos').snapshots().map(
        (query) {
          List<VideoModel> videos = [];
          for (var element in query.docs) {
            videos.add(VideoModel.fromSnap(element));
          }
          return videos;
        },
      ),
    );
  }

  likePost(String id) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('videos').doc(id).get();

    if ((documentSnapshot.data() as dynamic)['likes']
        .contains(authController.user.uid)) {
      firebaseFirestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove(
          [authController.user.uid],
        ),
      });
    } else {
      firebaseFirestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion(
          [authController.user.uid],
        ),
      });
    }
  }
}
