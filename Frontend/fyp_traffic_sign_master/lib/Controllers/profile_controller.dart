// ignore_for_file: avoid_print, unnecessary_this
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_model.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final isLoading = false.obs;
  Rx<UserModel> userDetails = UserModel.empty().obs;
  final _userRepo = Get.put(UserRepo());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

/* ----------- FETCHING USER DATA FROM FIRESTORE ----------- */
  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      await InternetConnectivity.checkInternet();

      final user = await _userRepo.fetchUserDetails();
      this.userDetails(user);
    } on NoNetwork catch (_) {
      CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'ALERT! No Internet Connection. Please check your network.');
      throw const NoNetwork();
    } catch (e) {
      userDetails(UserModel.empty());
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message:
            'Something Went Wrong in fetchUserRecord method - Profile Controller',
      );
    } finally {
      isLoading.value = false;
    }
  }

/* ----------- SAVING USER DATA IN FIRESTORE ----------- */
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final user = UserModel(
          id: userCredentials.user!.uid,
          fullname: userCredentials.user!.displayName ?? '',
          email: userCredentials.user!.email ?? '',
          mobileNum: userCredentials.user!.phoneNumber ?? '',
          password: userDetails.value.password,
          profilepicURL: userCredentials.user!.photoURL ?? '',
        );
        await _userRepo.saveUserRecord(user);
      }
    } catch (e) {
      CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Something Went Wrong Saving User-Data');
    }
    throw 'Method: saveUserRecord-ProfileController';
  }
}
