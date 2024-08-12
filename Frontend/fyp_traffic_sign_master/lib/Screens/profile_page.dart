// ignore_for_file: file_names, prefer_const_constructors, use_super_parameters

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart';
import 'package:fyp_traffic_sign_master/Screens/edit_profile.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:fyp_traffic_sign_master/Styles/reusable_widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.find<ProfileController>();
  final ProfileImageController profilepicController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // APPBAR
      appBar: AppBar(
        leading: const Icon(
          Icons.emoji_people,
          color: AppColors.white,
        ),
        title: Text(
          "Your Profile",
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: AppColors.buttonColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center),
            SizedBox(height: 35),

            // USER PROFILE PICTURE
            Obx(
              () {
                final profileImagePath =
                    Get.find<ProfileImageController>().profileImagePath;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonColor.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white12,
                    backgroundImage: profileImagePath.isNotEmpty
                        ? CachedNetworkImageProvider(profileImagePath.value)
                        : AssetImage('assets/images/profile.png')
                            as ImageProvider<Object>,
                  ),
                );
              },
            ),

            SizedBox(height: 25),

            // USERNAME
            Obx(
              () {
                final userName = profileController.userDetails.value.fullname;
                return Text(
                  userName.toUpperCase(),
                  style: ProfilePageTextStyle.headingText,
                );
              },
            ),

            // TAGLINE
            const SizedBox(height: 5),
            Obx(
              () {
                final userTagline =
                    profileController.userDetails.value.tagline ?? '';
                return Text('《 $userTagline 》'.toUpperCase(),
                    style: ProfilePageTextStyle.profileBody(
                        isSize15: true, isItalic: true));
              },
            ),

            SizedBox(height: 20),

            // PROFILE INFO CONTAINER
            Container(
              width: 320,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      
                      // USER EMAIL
                      Obx(
                        () {
                          return ProfilePageRow(
                            fieldName: "E-Mail",
                            fieldValue:
                                profileController.userDetails.value.email,
                            fieldIcon: Icons.mail_rounded,
                          );
                        },
                      ),
                      
                      // DIVIDER
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(color: AppColors.buttonColor),
                      ),

                      // USER MOBILE NUMBER
                      Obx(
                        () {
                          return ProfilePageRow(
                            fieldName: "Mobile",
                            fieldValue:
                                profileController.userDetails.value.mobileNum,
                            fieldIcon: Icons.call,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),

            // EDIT PROFILE BUTTON
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightPageRoute(
                    page: EditProfilePage(),
                    slideRight: true,
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.buttonColor,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.edit5,
                      color: AppColors.buttonColor,
                    ),
                    Row(
                      children: [
                        Text('  Edit Profile',
                            style: ProfilePageTextStyle.profileBody(
                                isSize15: true)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
