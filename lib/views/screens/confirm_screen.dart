import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/controllers/upload_video_controller.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController videoPlayerController;

  final UploadVideoController _uploadVideoController =
      Get.put(UploadVideoController());

  final TextEditingController songNameController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(videoPlayerController),
            ),
            SizedBox(height: 40.h),
            TextField(
              controller: songNameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  CupertinoIcons.music_note,
                  size: 35.r,
                ),
                hintText: 'Song Name',
                hintStyle: TextStyle(fontSize: 20.sp),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: captionController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  CupertinoIcons.captions_bubble,
                  size: 35.r,
                ),
                hintText: 'Caption',
                hintStyle: TextStyle(fontSize: 20.sp),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: buttonColor,
              ),
              onPressed: () {
                _uploadVideoController.uploadVideo(
                  videoPath: widget.videoPath,
                  songName: songNameController.text,
                  caption: captionController.text,
                );
              },
              child: Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
