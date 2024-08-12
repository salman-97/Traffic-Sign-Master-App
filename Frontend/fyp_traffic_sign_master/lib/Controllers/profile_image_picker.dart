// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, depend_on_referenced_packages

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:fyp_traffic_sign_master/Components/colors.dart";
import "package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart";
import "package:fyp_traffic_sign_master/Controllers/select_picture.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";

// ignore: must_be_immutable
class ProfileImagePicker extends StatelessWidget {
  ImagePicker profileImagePicker = ImagePicker();
  final ProfileImageController profilepicController = Get.find();

  ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
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
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: profileImagePath.isNotEmpty
                    ? CachedNetworkImageProvider(profileImagePath.value)
                    : AssetImage("assets/images/profile.png")
                        as ImageProvider<Object>,
                backgroundColor: Colors.white12,
                radius: 80,
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            height: 18,
            child: InkWell(
              child: Icon(
                Icons.camera_alt_rounded,
                size: 35,
                color:
                    AppColors.buttonColor,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.buttonColor,
                    builder: (context) => bottomSheet(context));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.19,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Text(
            "CHOOSE PROFILE PHOTO",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontFamily: 'Poppins Medium',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GALLERY
              InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 40, // ICON SIZE
                      color: AppColors.white,
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontFamily: 'Poppins Medium',
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  choosePhoto(
                      context, ImageSource.gallery, profilepicController);
                },
              ),
              SizedBox(
                width: 60,
              ),
              // CAMERA
              InkWell(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 40,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontFamily: 'Poppins Medium',
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  choosePhoto(
                      context, ImageSource.camera, profilepicController);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
