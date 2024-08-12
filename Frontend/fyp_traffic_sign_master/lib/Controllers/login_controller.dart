// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/login_failure.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_auth.dart';
import 'package:fyp_traffic_sign_master/Components/clear_fields.dart';
import 'package:fyp_traffic_sign_master/Components/custom_navbar.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    try {
      await InternetConnectivity.checkInternet();

      await UserAuthentication.instance
          .loginwithEmailAndPassword(emailController.text, passController.text);

      // call fetchUserDetails after updating user profile
      await ProfileController.instance.fetchUserRecord();

      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Login Successful',
      );

      Get.offAll(() => const CustomNavBar());

      final user = FirebaseAuth.instance.currentUser;
      final imageUrl = await getProfileImageUrl(user);

      Get.find<ProfileImageController>().setProfileImagePath(imageUrl);
      clearLoginFields();
    } on NoNetwork catch (_) {
      CustomSnackBar.show(context: Get.overlayContext!, message: _.message);
    } on LoginWithEmailAndPassFailure catch (e) {
      CustomSnackBar.show(context: Get.overlayContext!, message: e.message);
    }
  }

  Future<String> getProfileImageUrl(User? user) async {
    if (user == null) {
      print('User not Authenticated');
      return '';
    }

    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('profilepic_${user.uid}.jpg');

    try {
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error getting profile URL: $e');
      return '';
    }
  }
}
