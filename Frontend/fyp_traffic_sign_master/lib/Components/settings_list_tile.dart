import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.settingTitle,
    required this.settingSubTitle,
    this.trailing,
    this.onTap,
    this.showDivider = false,
    this.isDarkModeOn = false,
    this.isLocationOn = false,
  });

  final IconData icon;
  final String settingTitle, settingSubTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;
  final bool isDarkModeOn;
  final bool isLocationOn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            isDarkModeOn ? Icons.dark_mode : (isLocationOn ? Icons.location_on : icon),
            size: 30,
            color: AppColors.buttonColor,
          ),
          title: Text(
            settingTitle,
            style: const TextStyle(
              fontFamily: 'Poppins Medium',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            settingSubTitle,
            style: const TextStyle(
                fontFamily: 'Poppins Regular',
                fontSize: 12,
                color: AppColors.buttonColor),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Divider(
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}
