import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  pickVideo(BuildContext context, ImageSource source) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showDialogOption(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(context, ImageSource.gallery),
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  size: 35.r,
                ),
                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(context, ImageSource.camera),
            child: Row(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 35.r,
                ),
                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: [
                Icon(
                  Icons.cancel,
                  size: 35.r,
                ),
                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOption(context),
          child: Container(
            width: 180.w,
            height: 55.h,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
