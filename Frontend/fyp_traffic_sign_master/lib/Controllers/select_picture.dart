// ignore_for_file: unnecessary_null_comparison, avoid_print, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<void> choosePhoto(BuildContext context, ImageSource source, ProfileImageController profilepicController) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print('User is not Authenticated');
    return;
  }

  final picture = await ImagePicker().pickImage(
    source: source,
    imageQuality: 100,
  );

  if (picture == null) {
    print('User did not select profile picture');
    return;
  }

  final filename = 'profilepic_${user.uid}.jpg';
  Reference ref = FirebaseStorage.instance.ref().child(filename);

  try {
    final uploadTask = ref.putFile(File(picture.path));
    final snapshot = await uploadTask.whenComplete(() {});
    if (snapshot.state == TaskState.success) {
      final imageUrl = await ref.getDownloadURL();

      if (imageUrl != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({'ProfilePicUrl': imageUrl});

            profilepicController.setProfileImagePath(imageUrl);

        CustomSnackBar.show(
            context: Get.overlayContext!,
            message: 'Profile Picture Updated Successfully 😊');
        Get.back();
      } else {
        print('Image URL is null');
      }
    } else {
      print('Failed to upload Image:');
    }
  } catch (error, stackTrace) {
    print('Error Updating Profile Picture: $error');
    print('Stack Trace: $stackTrace');
  }
}
