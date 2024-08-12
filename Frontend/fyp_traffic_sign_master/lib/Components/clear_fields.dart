import 'package:fyp_traffic_sign_master/Controllers/login_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/signup_controller.dart';
import 'package:get/get.dart';

final signupController = Get.put(SignUpController());
final loginController = Get.put(LoginController());

void clearSignUpFields() {
  signupController.fullname.clear();
  signupController.email.clear();
  signupController.mobile.clear();
  signupController.password.clear();
  signupController.confirmpassword.clear();
}

void clearLoginFields() {
  loginController.loginFormKey.currentState?.reset();
  loginController.emailController.clear();
  loginController.passController.clear();
}
