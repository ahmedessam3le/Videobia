import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/models/user.dart' as model;
import 'package:videobia/views/screens/auth/login_screen.dart';
import 'package:videobia/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Rx<File?> _pickedImage = Rx<File?>(null);
  late Rx<User?> _user;

  File? get pickedImage => _pickedImage.value;

  @override
  onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialState);
  }

  _setInitialState(User? user) {
    if (user == null) {
      Get.offAll(LoginScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _pickedImage = Rx<File?>(File(pickedImage.path));
    }
  }

  Future<String> _uploadImageToStorage(File image) async {
    Reference reference = firebaseStorage
        .ref()
        .child('profile_pictures')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      {required String username,
      required String email,
      required String password,
      required File? image}) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        String imageUrl = await _uploadImageToStorage(image);

        model.User user = model.User(
          uid: credential.user!.uid,
          name: username,
          email: email,
          profilePicture: imageUrl,
        );
        await firebaseFirestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        Get.snackbar('Congratulations', 'Your Account is Ready');
        Get.offAll(LoginScreen());
      } else {
        Get.snackbar('Error Creating Account', 'Please Enter All Data');
      }
    } catch (error) {
      print('registerUser Error: $error');
      Get.snackbar('Error Creating Account', error.toString());
    }
  }

  void loginUser({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar('Login Error', 'Please Enter Your Email & Password');
      }
    } catch (error) {
      print('loginUser Error: $error');
      Get.snackbar('Login Error', error.toString());
    }
  }
}
