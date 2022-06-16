import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_compress/video_compress.dart';
import 'package:videobia/constants.dart';

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
      _uploadVideoToStorage(
          id: 'video ${allDocs.docs.length}', videoPath: videoPath);
    } catch (error) {
      print('uploadVideo Error : $error');
    }
  }
}
