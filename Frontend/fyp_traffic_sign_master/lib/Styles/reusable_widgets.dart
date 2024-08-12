
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:url_launcher/url_launcher.dart';

/* -------------------- GUIDE PAGE TEXT -------------------- */
class GuidePageText extends StatelessWidget {
  final String content;
  const GuidePageText({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(content,
          style:
              GuidePageTextStyle.guideBody(isColorBlack: true, isFontPR: true)),
    );
  }
}

/* -------------------- GUIDE PAGE IMAGE TEXT -------------------- */
class GuidePageImageText extends StatelessWidget {
  final String imageLabel;
  const GuidePageImageText({
    super.key,
    required this.imageLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Text(
            imageLabel,
            style: GuidePageTextStyle.tabsHeading(isSize18: false),
          )
        ],
      ),
    );
  }
}

/* -------------------- GUIDE PAGE IMAGE -------------------- */
class GuidePageImage extends StatelessWidget {
  final String imagePath;
  const GuidePageImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 140,
      height: 140,
      image: AssetImage(imagePath),
    );
  }
}

/* -------------------- PROFILE PAGE ROW -------------------- */
class ProfilePageRow extends StatelessWidget {
  final String fieldName;
  final String fieldValue;
  final IconData fieldIcon;

  const ProfilePageRow({
    super.key,
    required this.fieldName,
    required this.fieldValue,
    required this.fieldIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Icon(
            fieldIcon,
            size: 25,
            color: AppColors.buttonColor,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fieldName,
                style: ProfilePageTextStyle.profileBody(
                    isSize15: true, isBlack: true, isBold: true)),
            Text(fieldValue, style: ProfilePageTextStyle.profileBody())
          ],
        ),
      ],
    );
  }
}

/* -------------------- DEVELOPERS SOCIAL PROFILE BUTTON -------------------- */
class DevSocialProfile extends StatelessWidget {
  final String socialIcon;
  final String profileUrl;

  const DevSocialProfile({
    super.key,
    required this.socialIcon,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final profileUri = Uri.parse(profileUrl);
        launchUrl(profileUri, mode: LaunchMode.externalApplication);
      },
      child: Image.asset(
        socialIcon,
        width: 23,
        height: 23,
      ),
    );
  }
}
