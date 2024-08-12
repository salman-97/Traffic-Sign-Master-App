import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/developer_container.dart';
import 'package:fyp_traffic_sign_master/Components/dev_info.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "About Developers",
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
          },
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),

              // DEVELOPERS HEADING ☕︎
              Text('THE DEVELOPERS ☕︎',
                  style: AboutPageTextStyle.aboutBody(
                      isSize22: true, isBold: true, isColorBlack: false)),
              const SizedBox(height: 15),

              // CAROUSEL SLIDER
              CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  height: 180,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                itemBuilder: (context, index, realIndex) {
                  return _buildGrupMembers(index);
                },
              ),
              const SizedBox(height: 24),

              // OBJECTIVE HEADING
              Text('PROJECT OBJECTIVE 🎯',
                  style: AboutPageTextStyle.aboutBody(
                      isSize22: true, isBold: true, isColorBlack: false)),

              const SizedBox(height: 15),

              // OBJECTIVE TEXT CONTAINER
              Container(
                height: 250,
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: RichText(
                    text: TextSpan(
                      style: AboutPageTextStyle.aboutBody(
                          isColorBlack: true,
                          isWordSpace: true,
                          isFontPR: true),
                      children: const [
                        TextSpan(
                          text:
                              'Elevate road safety and driving efficiency through our Road Traffic Sign Recognition project. ',
                        ),
                        TextSpan(
                          text:
                              'Employing cutting-edge computer vision and machine learning, we\'re creating an intelligent system to effortlessly detect and interpret traffic signs, speed limits, stop signs, yield signs, and more with unwavering precision.',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // FYP LOGO
              const Image(
                  height: 110,
                  width: 260,
                  image: AssetImage('assets/images/fyp.png')),

              // IU LOGO
              const Image(
                  height: 80,
                  width: 260,
                  image: AssetImage('assets/images/iu.png')),
            ],
          ),
        ),
      ),
    );
  }

  // MEMBERS IN CAROUSEL
  _buildGrupMembers(int index) {
    switch (index) {
      case 0:
        return const Developers(
          memberName: dev1Name,
          memberEmail: dev1Email,
          memberImage: dev1Pic,
          facebookUrl: dev1Facebook,
          instagramUrl: dev1Instagram,
          linkedinUrl: dev1Linkedin,
          githubUrl: dev1Github,
          expertise: dev1Expertise,
        );

      case 1:
        return const Developers(
          memberName: dev2Name,
          memberEmail: dev2Email,
          memberImage: dev2Pic,
          facebookUrl: dev2Facebook,
          instagramUrl: dev2Instagram,
          linkedinUrl: dev2Linkedin,
          githubUrl: dev2Github,
          expertise: dev2Expertise,
        );

      case 2:
        return const Developers(
          memberName: dev3Name,
          memberEmail: dev3Email,
          memberImage: dev3Pic,
          facebookUrl: dev3Facebook,
          instagramUrl: dev3Instagram,
          linkedinUrl: dev3Linkedin,
          githubUrl: dev3Github,
          expertise: dev3Expertise,
        );
      default:
        return Container();
    }
  }
}
