// ignore_for_file: file_names, avoid_print, use_super_parameters, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/clear_fields.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Components/password_field.dart';
import 'package:fyp_traffic_sign_master/Controllers/fields_validation.dart';
import 'package:fyp_traffic_sign_master/Controllers/signup_controller.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/social_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/text_field.dart';
import 'package:fyp_traffic_sign_master/Screens/login_page.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController signupFormController = Get.find<SignUpController>();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isloading = false;
  Validation validate = Validation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: const Text(
          "Create Account",
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
            clearSignUpFields();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          // SIGN UP FORM
          child: Form(
            key: signupFormController.signupFormKey,
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 29, top: 17),

                    // SIGN UP TEXT
                    child: Text(
                      'Sign Up',
                      style: AuthPagesTextStyle.headingText(bold: false),
                    ),
                  ),
                ],
              ),

              // FULL NAME FIELD
              Container(
                margin: const EdgeInsets.only(left: 28, right: 30, top: 15),
                child: CustomTextField(
                  controller: signupFormController.fullname,
                  prefixIcon: Icons.person_2_outlined,
                  label: "Enter Full Name",
                  validator: validate.validateFname,
                  keyboardType: TextInputType.text,
                  errorTextStyle: const TextStyle(color: AppColors.buttonColor),
                ),
              ),

              // EMAIL FIELD
              Container(
                margin: const EdgeInsets.only(left: 28, right: 30, top: 15),
                child: CustomTextField(
                  controller: signupFormController.email,
                  prefixIcon: Icons.email_outlined,
                  label: "Enter Email",
                  validator: validate.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  errorTextStyle: const TextStyle(color: AppColors.buttonColor),
                ),
              ),

              // MOBILE NUMBER FIELD
              Container(
                margin: const EdgeInsets.only(left: 28, right: 30, top: 15),
                child: CustomTextField(
                  controller: signupFormController.mobile,
                  label: 'Mobile Number',
                  prefixIcon: Icons.phone_android_outlined,
                  validator: validate.validateMobile,
                  keyboardType: TextInputType.phone,
                  errorTextStyle: const TextStyle(color: AppColors.buttonColor),
                ),
              ),

              // PASSWORD FIELD
              Container(
                margin: const EdgeInsets.only(left: 27, right: 30, top: 15),
                child: CustomPasswordField(
                  controller: signupFormController.password,
                  label: 'Create Password',
                  validator: validate.validatePass,
                  errorTextStyle: const TextStyle(color: AppColors.buttonColor),
                ),
              ),

              // CONFIRM PASSWORD FIELD
              Container(
                margin: const EdgeInsets.only(left: 27, right: 30, top: 15),
                child: CustomPasswordField(
                  controller: signupFormController.confirmpassword,
                  label: 'Confirm Password',
                  validator: (value) {
                    return validate.validateConfirmPass(
                        value, signupFormController.password.text);
                  },
                  errorTextStyle: const TextStyle(color: AppColors.buttonColor),
                ),
              ),
              const SizedBox(height: 30),

              // SIGN UP BUTTON
              StatefulBuilder(
                builder: (context, setState) {
                  return GestureDetector(
                    onTap: () async {
                      if (!isloading &&
                          signupFormController.signupFormKey.currentState!
                              .validate()) {
                        try {
                          setState(() {
                            isloading = true;
                          });
                          FocusScope.of(context).unfocus();
                          await signupFormController.signup();
                          Navigator.push(
                            context,
                            SlideRightPageRoute(
                                page: const LoginPage(), slideRight: true),
                          );
                        } catch (e) {
                          print('Sign-Up Button Error $e');
                        } finally {
                          setState(() {
                            isloading = false;
                          });
                        }
                      }
                    },
                    child: Column(
                      children: [
                        isloading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.Switcherbutton),
                              )
                            : CustomButton(name: 'SIGN UP'),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // OR TEXT
              const Column(
                children: [
                  Text('OR', style: AuthPagesTextStyle.orText),
                ],
              ),

              // LOGIN WITH GOOGLE
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: SocialAuthButton(
                    name: 'Continue with Google',
                    imagePath: 'assets/images/google.png'),
              ),

              // LOGIN WITH FACEBOOK
              const SizedBox(height: 17),
              InkWell(
                onTap: () {},
                child: SocialAuthButton(
                    name: 'Continue with Facebook',
                    imagePath: 'assets/images/facebook.png'),
              ),
              const SizedBox(height: 20),

              // FOOTER TEXT & BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ALREADY HAVE ACCOUNT TEXT
                  const Text('Already have an account?',
                      style: AuthPagesTextStyle.footerText),

                  // SIGN IN LINK BUTTON
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(' Sign In',
                        style: AuthPagesTextStyle.footerLinkText),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
