import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message, // 255,149,35,35
    Color backgroundColor = AppColors.buttonColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontFamily: 'Poppins Medium'
          ),
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
