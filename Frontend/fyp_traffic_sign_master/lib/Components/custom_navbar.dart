// ignore_for_file: prefer_const_constructors, use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Screens/profile_page.dart';
import 'package:fyp_traffic_sign_master/Screens/trafficnews.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:fyp_traffic_sign_master/Controllers/tab_provider.dart';
import 'package:fyp_traffic_sign_master/Screens/home_page.dart';
import 'package:fyp_traffic_sign_master/Screens/map_page.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Consumer<TabIndexProvider>(
        builder: (context, tabProvider, child) {
          return Scaffold(
            body: IndexedStack(
              index: tabProvider.selectedIndex,
              children: const [HomePage(), MapPage(), TrafficNews(), ProfilePage()],
            ),
            bottomNavigationBar: Container(
              color: const Color(0xFF952323),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: GNav(
                  backgroundColor: const Color(0xFF952323),
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.red.withOpacity(0.2),
                  padding: const EdgeInsets.all(8),
                  gap: 8,
                  tabs: const [
                    GButton(
                      icon: Icons.home_outlined,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.location_on,
                      text: 'Map',
                    ),
                    GButton(
                      icon: Icons.newspaper_outlined,
                      text: 'News',
                    ),
                    GButton(
                      icon: Icons.person_2_outlined,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: tabProvider.selectedIndex,
                  onTabChange: (val) {
                    tabProvider.updateSelectedIndex(val);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
