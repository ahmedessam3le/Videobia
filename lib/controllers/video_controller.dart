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
}
