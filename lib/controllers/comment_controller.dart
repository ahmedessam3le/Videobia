import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _commentsList = Rx<List<CommentModel>>([]);

  List<CommentModel> get comments => _commentsList.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _commentsList.bindStream(
      firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map((query) {
        List<CommentModel> allComments = [];
        for (var element in query.docs) {
          allComments.add(CommentModel.fromSnap(element));
        }
        return allComments;
      }),
    );
  }

  postComment(String comment) async {
    try {
      if (comment.isNotEmpty) {
        DocumentSnapshot userDoc = await firebaseFirestore
            .collection('users')
            .doc(authController.user.uid)
            .get();

        var allComments = await firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        CommentModel commentModel = CommentModel(
          uid: authController.user.uid,
          username: (userDoc.data() as dynamic)['name'],
          profilePhoto: (userDoc.data() as dynamic)['profilePicture'],
          commentId: 'comment ${allComments.docs.length}',
          comment: comment,
          datePublished: DateTime.now(),
          likes: [],
          likedByMe: false,
        );

        await firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment ${allComments.docs.length}')
            .set(commentModel.toJson());

        await firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .update({'comments': allComments.docs.length + 1});
      }
    } catch (error) {
      print('postComment Error: ${error.toString()}');
      Get.snackbar('Comment Error', error.toString());
    }
  }

  likeComment(String id) async {
    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((documentSnapshot.data() as dynamic)['likes']
        .contains(authController.user.uid)) {
      firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove(
          [authController.user.uid],
        ),
        'likedByMe': false,
      });
    } else {
      firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion(
          [authController.user.uid],
        ),
        'likedByMe': true,
      });
    }
  }
}
