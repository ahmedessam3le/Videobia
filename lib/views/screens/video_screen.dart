import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:videobia/controllers/video_controller.dart';
import 'package:videobia/views/screens/comments_screen.dart';
import 'package:videobia/views/widgets/circle_animation.dart';
import 'package:videobia/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  final VideoController _videoController = Get.put(VideoController());

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 70.h,
      width: 70.w,
      child: Column(
        children: [
          Container(
            height: 65.h,
            width: 65.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(60.r),
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
            ),
            child: CircleAvatar(
              radius: 65.r,
              child: Image.network(
                profilePhoto,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _videoController.videosList.length,
          physics: BouncingScrollPhysics(),
          controller: PageController(initialPage: 0, viewportFraction: 1),
          itemBuilder: (context, index) {
            final video = _videoController.videosList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: video.videoUrl),
                Column(
                  children: [
                    SizedBox(height: 100.h),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(16.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    video.userName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    video.caption,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.music_note,
                                        size: 16.r,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        video.songName,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100.w,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  backgroundImage:
                                      NetworkImage(video.profilePhoto),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.favorite,
                                        size: 45.r,
                                      ),
                                    ),
                                    Text(
                                      video.likes.length.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommentsScreen(
                                              postId: video.videoId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.comment,
                                        size: 45.r,
                                      ),
                                    ),
                                    Text(
                                      video.comments.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.reply,
                                        size: 45.r,
                                      ),
                                    ),
                                    Text(
                                      video.shares.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                CircleAnimation(
                                  child: buildMusicAlbum(video.profilePhoto),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
