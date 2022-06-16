import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videobia/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: backgroundColor,
        activeColor: buttonColor,
        inactiveColor: Colors.white,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35.r,
            ),
            // label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 35.r,
            ),
            // label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 35.r,
            ),
            // label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30.r,
            ),
            // label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 35.r,
            ),
            // label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: pages[pageIndex],
      ),
    );
  }
}
