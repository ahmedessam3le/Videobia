import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as time_ago;
import 'package:videobia/controllers/comment_controller.dart';

class CommentsScreen extends StatelessWidget {
  final TextEditingController _commentTextEditingController =
      TextEditingController();
  final CommentController _commentController = Get.put(CommentController());
  final String postId;

  CommentsScreen({Key? key, required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _commentController.updatePostId(postId);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _commentController.comments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: NetworkImage(
                              _commentController.comments[index].profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              _commentController.comments[index].username,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            SizedBox(width: 14.w),
                            Text(
                              _commentController.comments[index].comment,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              time_ago.format(_commentController
                                  .comments[index].datePublished
                                  .toDate()),
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            SizedBox(width: 14.w),
                            Text(
                              '${_commentController.comments[index].likes.length} Likes',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            _commentController.likeComment(
                                _commentController.comments[index].commentId);
                          },
                          child: Icon(
                            Icons.favorite,
                            color: _commentController.comments[index].likedByMe
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              ListTile(
                title: TextFormField(
                  controller: _commentTextEditingController,
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    // border: OutlineInputBorder(),
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    _commentController
                        .postComment(_commentTextEditingController.text);
                    _commentTextEditingController.clear();
                  },
                  child: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
