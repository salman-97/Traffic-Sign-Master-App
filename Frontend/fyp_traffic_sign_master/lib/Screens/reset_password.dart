// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, use_super_parameters, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/clear_fields.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Components/text_field.dart';
import 'package:fyp_traffic_sign_master/Controllers/fields_validation.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Screens/change_password.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final mobileController = TextEditingController();
  final resetFormKey = GlobalKey<FormState>();
  Validation validate = Validation();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        backgroundColor: AppColors.buttonColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            clearLoginFields();
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 50),
        child: Form(
          key: resetFormKey,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FORGOT HEADING
                    Text('Forgot your Password ?',
                        style: ResetPasswordTextStyle.resetPasswordText(
                            isSize22: true, isBold: true)),
                    SizedBox(height: 5),

                    // FORGOT PASSWORD TEXT
                    Text(
                        'Enter your registered Mobile Number to request a password reset.',
                        style: ResetPasswordTextStyle.resetPasswordText()),
                    SizedBox(height: 25),

                    // MOBILE NUMBER FIELD
                    CustomTextField(
                      controller: mobileController,
                      label: 'Mobile Number',
                      prefixIcon: Icons.phone_android_outlined,
                      validator: validate.validateMobile,
                      keyboardType: TextInputType.phone,
                      errorTextStyle:
                          const TextStyle(color: AppColors.buttonColor),
                    ),

                    // RESET BUTTON
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 25),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return GestureDetector(
                            onTap: () async {
                              if (!isLoading &&
                                  resetFormKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                FocusScope.of(context).unfocus();
                                try {
                                  await InternetConnectivity.checkInternet();

                                  final mobileExist = await UserRepo.instance
                                      .checkMobileExistInDB(
                                          mobileController.text);
                                  if (mobileExist) {
                                    Navigator.push(
                                      context,
                                      SlideRightPageRoute(
                                          page: ChangePassword(
                                              userMobileNumber:
                                                  mobileController.text),
                                          slideRight: true),
                                    );
                                  } else {
                                    CustomSnackBar.show(
                                      context: Get.overlayContext!,
                                      message:
                                          "No Account Found for ${mobileController.text} 😕",
                                    );
                                  }
                                } on NoNetwork catch (_){
                                  InternetConnectivity.noInternetSnackBar();
                                } 
                                catch (e) {
                                  CustomSnackBar.show(
                                    context: Get.overlayContext!,
                                    message: "Error in Reseting Passowrd",
                                  );
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
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
                                    : CustomButton(name: 'RESET'),
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
}
