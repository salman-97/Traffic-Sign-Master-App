// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_auth.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_model.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Components/clear_fields.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final userRepository = Get.put(UserRepo());

  final fullname = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SIGNUP

  Future<void> signup() async {
    try {
      await InternetConnectivity.checkInternet();
      final userCredentials = await UserAuthentication.instance
          .registerWithEmailAndPassword(email.text, password.text);

      // SAVE USER DATA
      final newUser = UserModel(
        id: userCredentials.user!.uid,
        fullname: fullname.text,
        email: email.text,
        mobileNum: mobile.text,
        password: password.text,
        profilepicURL: '',
      );
      userRepository.saveUserRecord(newUser);

      CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Account Created Successfully. Please Login 😊');
      clearSignUpFields();
    } on NoNetwork catch (_) {
      CustomSnackBar.show(context: Get.overlayContext!, message: _.message);
      throw const NoNetwork();
    } catch (e) {
      print('Sign-Up Error: $e');
      throw "Error Occured in Signup Method in Signup Controller";
    }
  }
}
