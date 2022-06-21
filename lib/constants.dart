import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:videobia/controllers/auth_controller.dart';
import 'package:videobia/views/screens/add_video_screen.dart';
import 'package:videobia/views/screens/video_screen.dart';

// Pages

final pages = [
  VideoScreen(),
  Text('Search Screen'),
  AddVideoScreen(),
  Text('Messages Screen'),
  Text('Profile Screen'),
];

// Colors

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];

// Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

// Controller

var authController = AuthController.instance;
