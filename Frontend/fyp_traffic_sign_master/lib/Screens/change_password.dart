// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Components/password_field.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Controllers/fields_validation.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Screens/login_page.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  final String userMobileNumber;
  const ChangePassword({
    Key? key,
    required this.userMobileNumber,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;
  final changePassFormKey = GlobalKey<FormState>();
  Validation validate = Validation();
  final RxString username = ''.obs;
  final RxString useremail = ''.obs;
  final RxString userpass = ''.obs;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APPBAR
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        backgroundColor: AppColors.buttonColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 50),
        child: Form(
          key: changePassFormKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHANGE PASS HEADING
                    Text(
                      'CHANGE YOUR PASSWORD',
                      style: ResetPasswordTextStyle.resetPasswordText(
                          isSize22: true, isBold: true),
                    ),

                    SizedBox(height: 10),
                    // CHANGE PASSWORD TEXT WITH USERNAME FETCHED FOR THE MOBILE NUMBER
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          text: 'Hey ',
                          style: ResetPasswordTextStyle.resetPasswordText(),
                          children: [
                            TextSpan(
                                // verifying user old password here
                                text: username.value,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    ', let\'s create a stronger and easy to remember password for you.'),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 25),
                    // NEW PASSWORD FIELD
                    CustomPasswordField(
                      controller: passController,
                      label: 'Enter New Password',
                      validator: validate.validatePass,
                    ),

                    SizedBox(height: 25),
                    // CONFIRM NEW PASSWORD FIELD
                    CustomPasswordField(
                      controller: confirmPassController,
                      label: 'Confirm Password',
                      validator: (value) {
                        return validate.validateConfirmPass(
                            value, passController.text);
                      },
                    ),

                    // CHANGE BUTTON
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 25),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return GestureDetector(
                            onTap: () async {
                              if (!isLoading &&
                                  changePassFormKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await InternetConnectivity.checkInternet();

                                  await UserRepo.instance.resetUserPassword(
                                      widget.userMobileNumber,
                                      useremail.value,
                                      userpass.value.toString(),
                                      confirmPassController.text);
                                  CustomSnackBar.show(
                                      context: Get.overlayContext!,
                                      message:
                                          "Password Reset Successfully 😊");
                                  Navigator.push(
                                    context,
                                    SlideRightPageRoute(
                                        page: LoginPage(), slideRight: true),
                                  );
                                } on NoNetwork catch (_) {
                                  InternetConnectivity.noInternetSnackBar();
                                } catch (e) {
                                  CustomSnackBar.show(
                                      context: Get.overlayContext!,
                                      message: "Error in Reseting Passowrd");
                                  throw 'Error $e';
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                isLoading
                                    ? Center(
                                        child: const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColors.Switcherbutton),
                                        ),
                                      )
                                    : CustomButton(name: 'CHANGE'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// FUNCTION TO GET USER NAME FOR MOBILE NUMBER PROVIDED BY THE USER FROM FIREBASE
  Future<void> getUserName() async {
    try {
      final userData =
          await UserRepo.instance.userNameForMobile(widget.userMobileNumber);
      username.value = userData['name'] ?? 'User';
      useremail.value = userData['email'] ?? 'User';
      userpass.value = userData['password'] ?? 'User';
    } catch (error) {
      throw 'Error Getting Username in getUserName method in change_password.dart';
    }
  }
}
