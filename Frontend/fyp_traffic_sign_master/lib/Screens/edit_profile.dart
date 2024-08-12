// ignore_for_file: file_names, prefer_const_constructors, avoid_print, use_super_parameters

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Components/password_field.dart';
import 'package:fyp_traffic_sign_master/Components/text_field.dart';
import 'package:fyp_traffic_sign_master/Controllers/fields_validation.dart';
import 'package:fyp_traffic_sign_master/Controllers/no_internet.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_picker.dart';
import 'package:fyp_traffic_sign_master/Controllers/update_profile.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileController pcontroller = Get.find<ProfileController>();
  final updController = Get.put(UpdateProfileController());
  final editProfileKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  Validation validate = Validation();
  bool isLoading = false;

  @override
  void initState() {
    updController.initializeProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
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

            // PROFILE IMAGE
            ProfileImagePicker(),
            const SizedBox(height: 25),

            // USER NAME
            Obx(
              () => Text(
                pcontroller.userDetails.value.fullname.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.textColor,
                  fontFamily: 'Poppins Medium',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //const SizedBox(height: 20),

            // PROFILE CONTAINER
            Form(
              key: editProfileKey,
              child: Container(
                width: 330,
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
                    // TAGLINE FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 15),
                      child: CustomTextField(
                        controller: updController.taglineController,
                        label: "Tagline",
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.tag_faces_outlined,
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Poppins Medium',
                        ),
                        validator: (value) {
                          if (value != null && value.length > 20) {
                            return 'No more than 20 characters allowed';
                          }
                          return null;
                        },
                        errorTextStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                    ),

                    // NAME FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: CustomTextField(
                        controller: updController.nameController,
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
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: CustomTextField(
                        controller: updController.emailController,
                        prefixIcon: Icons.email_outlined,
                        label: "Email",
                        validator: validate.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        textStyle: TextStyle(fontStyle: FontStyle.italic),
                        errorTextStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                    ),

                    // MOBILE FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: CustomTextField(
                        controller: updController.mobileController,
                        prefixIcon: Icons.phone_android_outlined,
                        label: "Mobile Number",
                        validator: validate.validateMobile,
                        keyboardType: TextInputType.phone,
                        errorTextStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                    ),

                    // PASSWORD FIELD
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: CustomPasswordField(
                        controller: updController.passController,
                        validator: validate.validatePass,
                        label: "Password",
                        onSuffixIconPressed: (isObscure) {
                          setState(() {
                            obscurePassword = isObscure;
                          });
                        },
                        errorTextStyle:
                            const TextStyle(color: AppColors.buttonColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // SAVE PROFILE BUTTON
            StatefulBuilder(
              builder: (context, setState) {
                return GestureDetector(
                  onTap: () async {
                    if (!isLoading && editProfileKey.currentState!.validate()) {
                      try {
                        await InternetConnectivity.checkInternet();

                        setState(() {
                          isLoading = true;
                        });
                        bool anyUpdates =
                            updController.taglineController.text !=
                                    pcontroller.userDetails.value.tagline ||
                                updController.nameController.text !=
                                    pcontroller.userDetails.value.fullname ||
                                updController.emailController.text !=
                                    pcontroller.userDetails.value.email ||
                                updController.mobileController.text !=
                                    pcontroller.userDetails.value.mobileNum ||
                                updController.passController.text !=
                                    pcontroller.userDetails.value.password;

                        if (!anyUpdates) {
                          CustomSnackBar.show(
                            context: Get.overlayContext!,
                            message: 'No Changes made to the Profile.',
                          );
                          return;
                        }
                        await updController.updateProfile();
                      } on NoNetwork catch (_) {
                        CustomSnackBar.show(
                            context: Get.overlayContext!, message: _.message);
                      } catch (e) {
                        print('Save-Profile Button Error: $e');
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: SizedBox(
                    height: 60,
                    width: 320,
                    child: Column(
                      children: [
                        isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.Switcherbutton),
                              )
                            : CustomButton(name: 'SAVE PROFILE'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
