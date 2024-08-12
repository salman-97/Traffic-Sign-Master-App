// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/clear_fields.dart';
import 'package:fyp_traffic_sign_master/Components/password_field.dart';
import 'package:fyp_traffic_sign_master/Controllers/fields_validation.dart';
import 'package:fyp_traffic_sign_master/Controllers/login_controller.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:get/get.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/social_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Components/text_field.dart';
import 'package:fyp_traffic_sign_master/Screens/reset_password.dart';
import 'package:fyp_traffic_sign_master/Screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.find<LoginController>();
  //bool obscurePassword = true;
  bool isLoading = false;
  bool rememberMe = false;
  Validation validate = Validation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // LOGIN FORM
        child: Form(
          key: loginController.loginFormKey,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    // APP LOGO IMAGE
                    Image(
                      image: AssetImage('assets/images/Logo.png'),
                      height: 69,
                      width: 67,
                    ),
                    SizedBox(
                      height: 7,
                    ),

                    // APP NAME TEXT
                    Text(
                      'TRAFFIC SIGN MASTER',
                      style: AuthPagesTextStyle.headingText(bold: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 27),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 29),

                  // SIGN IN TEXT
                  Text(
                    'Sign in',
                    style: AuthPagesTextStyle.headingText(bold: false),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),

              // EMAIL FIELD
              Container(
                margin: const EdgeInsets.only(left: 27, right: 30, top: 15),
                child: CustomTextField(
                  controller: loginController.emailController,
                  label: "Enter Email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.text,
                  validator: validate.validateEmail,
                  errorTextStyle: TextStyle(color: AppColors.buttonColor),
                ),
              ),

              // PASSWORD FIELD
              Container(
                margin: const EdgeInsets.only(left: 27, right: 30, top: 15),
                child: CustomPasswordField(
                  controller: loginController.passController,
                  label: 'Enter Password',
                  validator: validate.validateLoginPass,
                  errorTextStyle: TextStyle(color: AppColors.buttonColor),
                ),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),

                    // Toggle SWITCH
                    child: Transform.scale(
                      scale: 0.56,
                      child: Switch(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.buttonColor,
                      ),
                    ),
                  ),

                  // REMEMBER ME
                  Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      },
                      child: Row(
                        children: const [
                          Text('Remember Me',
                              textAlign: TextAlign.right,
                              style: AuthPagesTextStyle.rememberMeText),
                        ],
                      ),
                    ),
                  ),

                  // FORGOT PASSWORD
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 9, right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            SlideRightPageRoute(
                              page: ResetPassword(),
                              slideRight: true,
                            ),
                          );
                          clearLoginFields();
                        },
                        child: Text(
                          'Forgot Password ?',
                          textAlign: TextAlign.right,
                          style: AuthPagesTextStyle.forgotPassText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // SIGN IN BUTTON
              StatefulBuilder(
                builder: (context, setState) {
                  return GestureDetector(
                    onTap: () {
                      if (!isLoading &&
                          loginController.loginFormKey.currentState!
                              .validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        FocusScope.of(context).unfocus();

                        LoginController.instance.loginUser().then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      }
                    },
                    child: Column(
                      children: [
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.Switcherbutton),
                              )
                            : CustomButton(name: 'SIGN IN'),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),

              // OR TEXT
              const Column(
                children: [
                  Text('OR', style: AuthPagesTextStyle.orText),
                ],
              ),

              // LOGIN WITH Google
              const SizedBox(height: 12),
              InkWell(
                onTap: () {},
                child: SocialAuthButton(
                    name: 'Login with Google',
                    imagePath: 'assets/images/google.png'),
              ),

              // LOGIN WITH Facebook
              const SizedBox(height: 17),
              InkWell(
                onTap: () {},
                child: SocialAuthButton(
                    name: ' Login with Facebook',
                    imagePath: 'assets/images/facebook.png'),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // DON'T HAVE AN ACCOUNT TEXT
                  const Text('Don’t have account?',
                      style: AuthPagesTextStyle.footerText),

                  // SIGN UP LINK BUTTON
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRightPageRoute(
                          page: SignUpPage(),
                          slideRight: true,
                        ),
                      );
                      clearLoginFields();
                    },
                    child: const Text(' Sign Up',
                        style: AuthPagesTextStyle.footerLinkText),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
