import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/views/screens/auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  File? imageAvatar;

  selectImage() async {
    authController.pickImage();
    if (authController.pickedImage != null) {
      setState(() {
        imageAvatar = authController.pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24.h),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    imageAvatar == null
                        ? CircleAvatar(
                            radius: 70.r,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ4TKmLL_Yab3zrnGsM-6FzOgBGSm3lcXkndb1E5xQagw5YlZ9ClcBcC46v3Eq9vfBSIQ&usqp=CAU',
                            ),
                          )
                        : CircleAvatar(
                            radius: 70.r,
                            backgroundColor: Colors.blue,
                            backgroundImage: FileImage(imageAvatar!),
                          ),
                    Positioned(
                      bottom: -15.h,
                      left: 85.w,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 40.r,
                        ),
                        onPressed: selectImage,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    hintText: 'Username',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30.r,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      size: 30.r,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30.r,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () => authController.registerUser(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    image: authController.pickedImage,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 55.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(fontSize: 22.sp),
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 22.sp, color: buttonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
