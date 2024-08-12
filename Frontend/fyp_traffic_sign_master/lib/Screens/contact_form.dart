// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Components/text_field.dart';
import 'package:fyp_traffic_sign_master/Controllers/fields_validation.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Screens/about_page.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final contactFormKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController msgController = TextEditingController();
  Validation validate = Validation();
  late FocusNode _focusNode = FocusNode();
  Color? _labelColor;
  bool isLoading = false;

  // INITIALIZING LABEL COLOR AND FOCUS LISTNER
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _labelColor = Colors.black54;
    _focusNode.addListener(_handleFocusChange);
  }

  // DISPOSING FOCUS
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // FUNCTION TO HAND MESSAGE FIELD FOCUS
  void _handleFocusChange() {
    if (!_focusNode.hasFocus && msgController.text.isEmpty) {
      setState(() {
        _labelColor = Colors.black54;
      });
    } else {
      _labelColor = AppColors.buttonColor;
    }
  }

  // FUNCTION TO REQUEST FIELD FOCUS
  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "Contact Us",
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
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
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(alignment: Alignment.center),
            const SizedBox(height: 10),

            // HEADER IMAGE
            Image.asset(
              "assets/images/contactus.png",
              width: 200,
              height: 120,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 10),

            // CONTACT US HEADING
            const Text("Need Assistance? Reach Us",
                style: ContactUsPageTextStyle.contactHeading),
            const SizedBox(height: 10),

            // CONTACT US FORM
            Form(
              key: contactFormKey,
              child: Container(
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.buttonColor.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // FULL NAME FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 15),
                      child: CustomTextField(
                        controller: fnameController,
                        prefixIcon: Icons.person_2_outlined,
                        label: "Full Name",
                        validator: validate.validateFname,
                        keyboardType: TextInputType.text,
                        errorTextStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                    ),

                    // EMAIL FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 15),
                      child: CustomTextField(
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                        label: "Enter Email",
                        validator: validate.validateEmail,
                        keyboardType: TextInputType.text,
                        errorTextStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                    ),

                    // MESSAGE FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: msgController,
                        focusNode: _focusNode,
                        onTap: _requestFocus,
                        decoration: InputDecoration(
                          prefixIcon: _focusNode.hasFocus
                              ? null
                              : const Icon(Iconsax.message),
                          labelText: 'Suggestions or Queries',
                          labelStyle: TextStyle(
                            color: _focusNode.hasFocus
                                ? AppColors.buttonColor
                                : _labelColor,
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 14, left: 16, right: 16, bottom: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.buttonColor,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFE4DFDF),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          errorStyle: const TextStyle(
                            color: AppColors.buttonColor,
                          ),
                        ),
                        maxLines: 8,
                        maxLength: 250,
                        validator: validate.validateMsg,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // SUBMIT BUTTON
            InkWell(
              onTap: () async {
                if (contactFormKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  FocusScope.of(context).unfocus();
                  await UserRepo.instance.storeUserFeedback(
                      fnameController.text,
                      emailController.text,
                      msgController.text);
                  setState(() {
                    isLoading = false;
                  });
                  CustomSnackBar.show(
                    context: Get.overlayContext!,
                    message: "Thanks for Reaching Us Out 😊",
                  );
                  clearContactFields();
                }
              },
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.buttonColor),
                    )
                  : CustomButton(name: "SUBMIT"),
            ),
            const SizedBox(height: 15),

            // OR TEXT
            const Text('OR', style: AuthPagesTextStyle.orText),
            const SizedBox(height: 8),

            // CONTACT US FOOTER
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Reach ♥ ", style: AuthPagesTextStyle.footerText),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRightPageRoute(
                          page: const AboutUsPage(), slideRight: true),
                    );
                  },
                  child: const Text("The Developers",
                      style: AuthPagesTextStyle.footerLinkText),
                ),
                const Text("  ☕︎"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // CLEAR FIELD FUNCTION
  void clearContactFields() {
    fnameController.clear();
    emailController.clear();
    msgController.clear();
  }
}
