import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/models/video.dart';

class UploadVideoController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.HighestQuality,
    );

    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(
      {required String id, required String videoPath}) async {
    Reference reference = firebaseStorage.ref('videos').child(id);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String videoUrl = await taskSnapshot.ref.getDownloadURL();

    return videoUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = VideoCompress.getFileThumbnail(videoPath);

    return thumbnail;
  }

  Future<String> _uploadThumbnailToStorage(
      {required String id, required String videoPath}) async {
    Reference reference = firebaseStorage.ref('thumbnails').child(id);
    UploadTask uploadTask = reference.putFile(await _getThumbnail(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String videoUrl = await taskSnapshot.ref.getDownloadURL();

    return videoUrl;
  }

  uploadVideo({
    required String videoPath,
    required String songName,
    required String caption,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firebaseFirestore.collection('users').doc(uid).get();
      var allDocs = await firebaseFirestore.collection('videos').get();

      String videoUrl = await _uploadVideoToStorage(
        id: 'video ${allDocs.docs.length}',
        videoPath: videoPath,
      );

      String thumbnail = await _uploadThumbnailToStorage(
        id: 'video ${allDocs.docs.length}',
        videoPath: videoPath,
      );

      VideoModel videoModel = VideoModel(
        uid: uid,
        userName: (userDoc.data() as Map<String, dynamic>)['name'],
        profilePhoto:
            (userDoc.data() as Map<String, dynamic>)['profilePicture'],
        videoId: 'video ${allDocs.docs.length}',
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        caption: caption,
        songName: songName,
        likes: [],
        comments: 0,
        shares: 0,
      );

      await firebaseFirestore
          .collection('videos')
          .doc('video ${allDocs.docs.length}')
          .set(videoModel.toJson());

      Get.back();
    } catch (error) {
      print('uploadVideo Error : $error');
      Get.snackbar('Upload Video Error', error.toString());
    }
  }
}
