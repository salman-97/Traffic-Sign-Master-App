// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:fyp_traffic_sign_master/Styles/reusable_widgets.dart';

class Developers extends StatelessWidget {
  final String memberName;
  final String memberEmail;
  final String memberImage;
  final String facebookUrl;
  final String instagramUrl;
  final String linkedinUrl;
  final String githubUrl;
  final String expertise;

  const Developers({
    Key? key,
    required this.memberName,
    required this.memberEmail,
    required this.memberImage,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.expertise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // MEMBER IMAGE CONTAINER
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.buttonColor.withOpacity(0.8),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              // MEMBER IMAGE
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(memberImage),
              ),
            ),
            const SizedBox(width: 8.0),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MEMBER NAME
                  Text(
                    memberName,
                    style: AboutPageTextStyle.devContainer(),
                  ),

                  // MEMBER EMAIL
                  Text(
                    memberEmail,
                    style: AboutPageTextStyle.devContainer(
                        isSize12: false, isFontPR: false, isBold: false),
                  ),
                  const SizedBox(height: 8),

                  // MEMBER SOCIALS
                  Row(
                    children: [
                      DevSocialProfile(
                          socialIcon: 'assets/images/facebook.png',
                          profileUrl: facebookUrl),
                      const SizedBox(width: 12),
                      DevSocialProfile(
                          socialIcon: 'assets/images/instagram.png',
                          profileUrl: instagramUrl),
                      const SizedBox(width: 12),
                      DevSocialProfile(
                          socialIcon: 'assets/images/linkedin.png',
                          profileUrl: linkedinUrl),
                      const SizedBox(width: 12),
                      DevSocialProfile(
                          socialIcon: 'assets/images/github.png',
                          profileUrl: githubUrl),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // MEMBER EXPERTISE
                  Row(
                    children: [
                      Text(
                        expertise,
                        style: AboutPageTextStyle.devContainer(
                            isColorBlack: false),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
