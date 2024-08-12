// ignore_for_file: file_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Styles/reusable_widgets.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';

class Guidepage extends StatefulWidget {
  const Guidepage({Key? key}) : super(key: key);

  @override
  State<Guidepage> createState() => _GuidepageState();
}

class _GuidepageState extends State<Guidepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // APPBAR & TAB BAR
        appBar: AppBar(
          title: const Text(
            'Guide - Traffic Signs Info',
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

          // TAB BAR
          bottom: TabBar(
            labelPadding: const EdgeInsets.symmetric(vertical: 5),
            indicatorColor: Colors.yellow,
            tabs: [
              Text('Information',
                  style: GuidePageTextStyle.guideBody(isColorBlack: false)),
              Text('Guide',
                  style: GuidePageTextStyle.guideBody(isColorBlack: false)),
              Text('Regulatory',
                  style: GuidePageTextStyle.guideBody(isColorBlack: false)),
              Text('Warning',
                  style: GuidePageTextStyle.guideBody(isColorBlack: false)),
            ],
          ),
        ),
        body: TabBarView(children: [
          // INFORMATION TAB CONTENT
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text('Information Traffic Signs',
                    style: GuidePageTextStyle.tabsHeading(isSize18: true)),
                const SizedBox(height: 15),
                const GuidePageText(
                  content:
                      'Informative signs are rectangular and look like expressway signs but,'
                      'they give drivers information about their destination and any roadside services',
                ),

                // SIGN 1
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Telephone'),
                const GuidePageImage(imagePath: 'assets/images/telephone.png'),

                // SIGN 2
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Parking Place'),
                const GuidePageImage(imagePath: 'assets/images/parking.png'),

                // SIGN 3
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Hospital Ahead'),
                const GuidePageImage(imagePath: 'assets/images/hospital.png'),

                // SIGN 4
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Bus Stop'),
                const GuidePageImage(imagePath: 'assets/images/bus.png'),
              ],
            ),
          ),

          // GUIDE TAB CONTENT
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text('Guide Signs',
                    style: GuidePageTextStyle.tabsHeading(isSize18: true)),
                const SizedBox(height: 15),
                const GuidePageText(
                    content:
                        'Guide signs provide mileage and directional information to travelers.'),
                // SIGN 1
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Crossover Sign'),
                const GuidePageImage(imagePath: 'assets/images/crossover.png'),

                // SIGN 2
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Freeway Entrance'),
                const GuidePageImage(imagePath: 'assets/images/freeway.png'),

                // SIGN 3
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Bike Route'),
                const GuidePageImage(imagePath: 'assets/images/bikeroute.png'),

                // SIGN 4
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Alternative Fuel Sign'),
                const SizedBox(height: 10),
                const GuidePageImage(imagePath: 'assets/images/cng.png'),
              ],
            ),
          ),

          // REGULATORY TAB CONTENT
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text('Regulatory Traffic Signs',
                    style: GuidePageTextStyle.tabsHeading(isSize18: true)),
                const SizedBox(height: 15),
                const GuidePageText(
                    content:
                        'Regulatory signs tell drivers what they can and cannot do such as Stop Sign, Yield Sign, No-Turn On Red Sign, or Speed Limit Sign.'),
                // SIGN 1
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Stop Sign'),
                const GuidePageImage(imagePath: 'assets/images/stop.png'),

                // SIGN 2
                const SizedBox(height: 15),
                const GuidePageImageText(
                    imageLabel: 'Heavy Vehicles Prohibited'),
                const SizedBox(height: 15),
                const GuidePageImage(imagePath: 'assets/images/notrucks.png'),

                // SIGN 3
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'No Right Turn Sign'),
                const SizedBox(height: 15),
                const GuidePageImage(imagePath: 'assets/images/noright.png'),

                // SIGN 4
                const SizedBox(height: 16),
                const GuidePageImageText(
                    imageLabel: 'Vehicles on Railway Tracks Prohibited'),
                const SizedBox(height: 15),
                const GuidePageImage(imagePath: 'assets/images/caronrails.png'),
              ],
            ),
          ),

          // WARNING TAB CONTENT
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text('Traffic Warning Signs',
                    style: GuidePageTextStyle.tabsHeading(isSize18: true)),
                const SizedBox(height: 15),
                const GuidePageText(
                    content:
                        'Warning signs are used to alert highway, street or road users to unexpected or dangerous conditions ahead that might call for a reduction of speed, situations that might not be readily apparent, or an action in the interest of safety and efficient traffic operations such as a curve, detour, sideroad, etc'),
                // SIGN 1
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'No Cellphone Usage'),
                const GuidePageImage(imagePath: 'assets/images/notexting.png'),

                // SIGN 2
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Winding / Curvy Road'),
                const SizedBox(height: 10),
                const GuidePageImage(imagePath: 'assets/images/winding.png'),

                // SIGN 3
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'Bicycles Zone'),
                const SizedBox(height: 10),
                const GuidePageImage(imagePath: 'assets/images/bicycle.png'),

                // SIGN 4
                const SizedBox(height: 15),
                const GuidePageImageText(imageLabel: 'School Zone'),
                const SizedBox(height: 10),
                const GuidePageImage(imagePath: 'assets/images/school.png'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
