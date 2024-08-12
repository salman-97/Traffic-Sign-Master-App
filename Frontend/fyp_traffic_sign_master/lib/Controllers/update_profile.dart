// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_model.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();
  final pController = ProfileController.instance;
  final profileimageController = ProfileImageController.instance;
  final _userRepo = Get.put(UserRepo());

  /* ----------- TEXT EDITING CONTROLLERS ----------- */
  final taglineController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passController = TextEditingController();

  @override
  void onInit() {
    initializeProfile();
    super.onInit();
  }

  Future<void> initializeProfile() async {
    taglineController.text = pController.userDetails.value.tagline ?? '';
    nameController.text = pController.userDetails.value.fullname;
    emailController.text = pController.userDetails.value.email;
    mobileController.text = pController.userDetails.value.mobileNum;
    passController.text = pController.userDetails.value.password;
  }

  Future<void> updateProfile() async {
    try {
      await InternetConnectivity.checkInternet();

      // USERMODEL
      final updatedUser = UserModel(
        id: pController.userDetails.value.id,
        tagline: taglineController.text,
        fullname: nameController.text,
        email: emailController.text,
        mobileNum: mobileController.text,
        password: passController.text,
        profilepicURL: profileimageController.profileImagePath.toString(),
      );

      /* ----------- Check Email Existence Before Updating ----------- */
      final emailExists = await _userRepo.emailExistExceptCurrentUser(
          updatedUser.email, pController.userDetails.value.email);

      /* ----------- Check Mobile Existence Before Updating ----------- */
      final mobileExists = await _userRepo.mobileExistExceptCurrentUser(
          updatedUser.mobileNum, pController.userDetails.value.mobileNum);

      if (emailExists) {
        CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Email Already In-Use. Check Email !',
        );
        return;
      }

      if (mobileExists) {
        CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Mobile Already In-Use. Check Mobile !',
        );
        return;
      }

      /* ------- Update User Email in Firebase AUTHENTICATION ------- */
      await _userRepo.updateUserEmail(updatedUser.email);

      /* ------- Update User Password in Firebase AUTHENTICATION ------- */
      await _userRepo.updateUserPassword(pController.userDetails.value.email,
          pController.userDetails.value.password, updatedUser.password);

      /* ------- Update Details in Firebase FIRESTORE ------- */
      await _userRepo.updateUserDetails(updatedUser);

      /* ------- Updating User Model with UPDATED Values ------- */
      pController.userDetails.value = updatedUser;

      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Profile Updated Successfully 😊',
      );
    } on NoNetwork catch (_) {
      CustomSnackBar.show(context: Get.overlayContext!, message: _.message);
    } catch (e) {
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'Error Updating User Profile',
      );
      throw 'Method: updateProfile - UpdateProfileController';
    }
  }
}
