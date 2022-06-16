import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/views/screens/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(height: 40.h),
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
              onTap: () => authController.loginUser(
                  email: _emailController.text,
                  password: _passwordController.text),
              child: Container(
                width: MediaQuery.of(context).size.width - 55.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    'Login',
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
                  'Don\'t have an account ? ',
                  style: TextStyle(fontSize: 22.sp),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    ' Register',
                    style: TextStyle(fontSize: 22.sp, color: buttonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
