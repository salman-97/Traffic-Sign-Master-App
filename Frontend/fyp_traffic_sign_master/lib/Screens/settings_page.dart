import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Components/settings_list_tile.dart';
import 'package:fyp_traffic_sign_master/Controllers/app_settings.dart';
import 'package:fyp_traffic_sign_master/Screens/app_policies.dart';
import 'package:fyp_traffic_sign_master/Screens/contact_form.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool isLocation = false;

  // INITIALIZING DARKMODE SETTINGS AND LOCATION SERVICES ON PAGE LOAD
  @override
  void initState() {
    super.initState();
    _loadDarkModeSetting();
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "App Settings",
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 8, right: 5),
              child: Column(
                children: [
                  // SETTINGS HEADING
                  Text(
                      "Personalized settings to match your preferences and needs",
                      style: SettingsPageTextStyle.headerText),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // DARK MODE SETTINGS
            SettingsTile(
              icon: Icons.dark_mode_outlined,
              settingTitle: "DARK MODE",
              settingSubTitle:
                  isDarkMode ? "Dark Mode is ON" : "Swtich to Dark Mode",
              trailing: Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                      _saveDarkModeSetting(value);
                      CustomSnackBar.show(
                          context: Get.overlayContext!,
                          message: "Application Appearance in Progress ☕︎");
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.buttonColor,
                ),
              ),
              showDivider: true,
              isDarkModeOn: isDarkMode,
            ),

            // LOCATION SETTINGS
            SettingsTile(
              icon: Icons.location_on_outlined,
              settingTitle: "LOCATION",
              settingSubTitle: isLocation
                  ? "Location Services are ON"
                  : "Location Services are OFF",
              trailing: Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: isLocation,
                  onChanged: (value) {
                    if (!isLocation) {
                      _checkLocationStatus(value);
                    } else {
                      null;
                    }
                  },
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.buttonColor,
                ),
              ),
              showDivider: true,
              isLocationOn: isLocation,
            ),

            // NOTIFICATION SETTINGS
            SettingsTile(
              icon: Icons.notifications,
              settingTitle: "NOTIFICATIONS",
              settingSubTitle: "Manage application notifications",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.buttonColor,
              ),
              onTap: () {
                openApplicationSettings();
              },
              showDivider: true,
            ),

            // STORAGE & DATA SETTINGS
            SettingsTile(
              icon: Icons.storage_rounded,
              settingTitle: "STORAGE & DATA",
              settingSubTitle: "Manage App Storage and Data",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.buttonColor,
              ),
              onTap: () {
                openApplicationSettings();
              },
              showDivider: true,
            ),

            // HELP SETTINGS
            SettingsTile(
              icon: Icons.help,
              settingTitle: "HELP CENTER",
              settingSubTitle: "Looking for Help ? Reach Us",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.buttonColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightPageRoute(
                      page: const ContactUsPage(), slideRight: true),
                );
              },
              showDivider: true,
            ),

            // PRIVACY POLICY SETTINGS
            SettingsTile(
              icon: Icons.policy_sharp,
              settingTitle: "PRIVACY POLICY",
              settingSubTitle: "View Application Privacy Policies",
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.buttonColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightPageRoute(
                      page: const AppPoliciesAndLicenses(), slideRight: true),
                );
              },
              showDivider: true,
            ),

            // SETTINGS FOOTER
            Padding(
              padding: const EdgeInsets.only(top: 65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/images/Logo.png",
                    width: 42,
                    height: 42,
                  ),
                  const SizedBox(height: 10),
                  Text("TRAFFIC SIGN MASTER",
                      style: SettingsPageTextStyle.footerText(
                          isSize11: false, isBold: true, isRed: true)),
                  Text("Version 1.0.0 Build - Release v0.0.1",
                      style: SettingsPageTextStyle.footerText(
                          isSize11: true, isItalic: true)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FUNCTION TO LOAD DARKMODE SETTINGS
  Future<void> _loadDarkModeSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // FUNCTION TO SAVE DARKMODE SETTINGS
  Future<void> _saveDarkModeSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  // FUNCTION TO CHECK LOCATION PERMISSION STATUS
  Future<void> _checkLocationPermission() async {
    Location location = Location();
    PermissionStatus status = await location.hasPermission();

    setState(() {
      isLocation = status == PermissionStatus.granted;
    });
  }

  // FUNCTION TO ASK LOCATION PERMISSION
  Future<void> _checkLocationStatus(bool value) async {
    Location location = Location();
    PermissionStatus status = await location.hasPermission();

    if (value) {
      if (status != PermissionStatus.granted) {
        status = await location.requestPermission();
      }

      if (status == PermissionStatus.granted) {
        setState(() {
          isLocation = true;
        });
      }
    } else {
      setState(() {
        isLocation = false;
      });
    }
  }
}
