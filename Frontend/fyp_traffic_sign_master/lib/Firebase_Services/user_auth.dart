import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/login_failure.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/signup_failure.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/login_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/signup_controller.dart';
import 'package:fyp_traffic_sign_master/Screens/splashscreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthentication extends GetxController {
  static UserAuthentication get instance => Get.find();
  final signupController = Get.find<SignUpController>();
  final loginController = Get.find<LoginController>();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;
  late Rx<User?> firebaseUser;
  final String _userKey = 'userKey';

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      final prefs = await SharedPreferences.getInstance();
      final storedUser = prefs.getString(_userKey);

      if (storedUser != null) {
        try {
          loginwithEmailAndPassword(storedUser, '');
        } catch (e) {
          throw 'Login Error: $e';
        }
      } else {
        Get.offAll(() => const SplashScreen());
      }
    }
  }

  /* ----------------------- EMAIL AND PASSWORD SIGN-UP ----------------------- */
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final mobileExist =
          await UserRepo.instance.mobileExist(signupController.mobile.text);
      final emailExist = await UserRepo.instance.emailExist(email);

      if (emailExist && mobileExist) {
        CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Account already exists with Email & Mobile',
        );
        throw 'Account Exists';
      } else if (mobileExist) {
        CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Mobile Number already Linked with another account !',
        );
        throw 'Mobile already exists';
      } else if (emailExist) {
        CustomSnackBar.show(
          context: Get.overlayContext!,
          message: 'Email already Linked with another account !',
        );
        throw 'Email already exists';
      } else {
        return await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPassFailure.code(e.code);
      CustomSnackBar.show(
        context: Get.overlayContext!,
        message: ex.message,
      );
      throw ex.message;
    } catch (e) {
      throw e.toString();
    }
  }

  /* ----------------------- EMAIL AND PASSWORD Login ----------------------- */
  Future<UserCredential> loginwithEmailAndPassword(
      String email, String password) async {
    try {
      final userCreds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, email);

      return userCreds;
    } on FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPassFailure.code(e);
    } catch (_) {
      throw const LoginWithEmailAndPassFailure();
    }
  }

/* ----------------------- LOGOUT ----------------------- */
  Future<void> logout() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    loginController.emailController.clear();
    loginController.passController.clear();
  }
}
