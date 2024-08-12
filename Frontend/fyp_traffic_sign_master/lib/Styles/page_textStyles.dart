// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

/*---------- AUTHENTICATION LOGIN - SIGNUP TEXT STYLES ----------*/
class AuthPagesTextStyle {
  static TextStyle headingText({bool bold = false}) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins Medium',
      color: AppColors.textColor,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }

  static const rememberMeText = TextStyle(
    color: AppColors.textColor,
    fontSize: 12,
    fontFamily: 'Poppins Regular',
  );

  static const forgotPassText = TextStyle(
    fontSize: 12,
    fontFamily: 'Poppins Regular',
    color: AppColors.textColor,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.buttonColor,
    decorationThickness: 2.0,
  );

  static const orText = TextStyle(
    color: Colors.black54,
    fontSize: 18,
    fontFamily: 'Poppins Medium',
  );

  static const footerText = TextStyle(
    fontSize: 15,
    fontFamily: 'Poppins Regular',
    color: Color(0xFF120D26),
  );

  static const footerLinkText = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins Regular',
    fontWeight: FontWeight.bold,
    color: AppColors.buttonColor,
  );
}

/*---------- HOME PAGE TEXT STYLES ----------*/
class HomePageTextStyles {
  static TextStyle userNameText({bool white = true, size20 = false}) {
    return TextStyle(
      color: white ? Colors.white : Colors.black,
      fontFamily: 'Poppins Regular',
      fontSize: size20 ? 20 : 17,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle baseText(
      {bool bold = true, red = false, italic = false, size15 = false}) {
    return TextStyle(
      fontSize: size15 ? 15 : 14,
      fontFamily: 'Poppins Regular',
      color: red ? AppColors.buttonColor : AppColors.textColor,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    );
  }

  static const drawerText = TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins Medium',
      fontWeight: FontWeight.w500,
      color: Colors.black);
}

/*---------- CONTACT US TEXT STYLES ----------*/
class ContactUsPageTextStyle {
  static const contactHeading = TextStyle(
      fontFamily: 'Poppins Medium',
      fontSize: 18,
      color: AppColors.buttonColor,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);
}

/*---------- GUIDE PAGE TEXT STYLES ----------*/
class GuidePageTextStyle {
  static TextStyle guideBody({isFontPR = false, isColorBlack = false}) {
    return TextStyle(
        fontFamily: isFontPR ? 'Poppins Regular' : 'Poppins Medium',
        color: isColorBlack ? AppColors.textColor : AppColors.white,
        fontSize: 14);
  }

  static TextStyle tabsHeading({bool isSize18 = false}) {
    return TextStyle(
      fontFamily: 'Poppins Medium',
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
      fontSize: isSize18 ? 18 : 16,
    );
  }
}

/*---------- ABOUT PAGE TEXT STYLES ----------*/
class AboutPageTextStyle {
  static TextStyle devContainer(
      {bool isSize12 = false,
      isBold = true,
      isFontPR = true,
      isColorBlack = true}) {
    return TextStyle(
      fontSize: isSize12 ? 12 : 11,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: isFontPR ? 'Poppins Regular' : 'Poppins Medium',
      color: isColorBlack ? Colors.black : AppColors.buttonColor,
      fontStyle: FontStyle.italic,
    );
  }

  static TextStyle aboutBody(
      {bool isFontPR = false,
      isSize22 = false,
      isColorBlack = false,
      isWordSpace = false,
      isBold = false}) {
    return TextStyle(
      fontSize: isSize22 ? 22 : 16,
      fontFamily: isFontPR ? 'Poppins Regular' : 'Poppins Medium',
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: isColorBlack ? AppColors.textColor : AppColors.buttonColor,
      wordSpacing: isWordSpace ? 3.0 : 0.0,
    );
  }
}

/*---------- APP POLICY PAGE TEXT STYLES ----------*/
class AppPolicyTextStyle {
  static TextStyle appPolicyBody(
      {bool isSize16 = false, isColorBlack = false, isBold = false}) {
    return TextStyle(
      fontFamily: 'Poppins Medium',
      fontSize: isSize16 ? 16 : 15,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: isColorBlack ? Colors.black : AppColors.buttonColor,
    );
  }
}

/*---------- PROFILE PAGE TEXT STYLES ----------*/
class ProfilePageTextStyle {
  static const headingText = TextStyle(
      fontFamily: 'Poppins Regular', fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle profileBody(
      {bool isSize15 = false,
      isBold = false,
      isItalic = false,
      isBlack = false}) {
    return TextStyle(
      fontFamily: 'Poppins Regular',
      fontSize: isSize15 ? 15 : 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      color: isBlack ? AppColors.textColor : AppColors.buttonColor,
    );
  }
}

/*---------- OUTPUT PAGE TEXT STYLES ----------*/
class OutputPageTextStyle {
  static TextStyle headerText(
      {bool isSize22 = false,
      isBold = false,
      isItalic = false,
      isBlack = true}) {
    return TextStyle(
      fontFamily: 'Poppins Regular',
      fontSize: isSize22 ? 22 : 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      color: isBlack ? AppColors.textColor : AppColors.buttonColor,
    );
  }

  static const bodyText = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins Regular',
    fontWeight: FontWeight.bold,
  );
}

/*---------- SETTINGS PAGE TEXT STYLES ----------*/
class SettingsPageTextStyle {
  static const headerText = TextStyle(fontFamily: 'Poppins Medium');

  static TextStyle footerText(
      {bool isSize11 = false,
      isBold = false,
      isItalic = false,
      isRed = false}) {
    return TextStyle(
      fontFamily: 'Poppins Regular',
      fontSize: isSize11 ? 11 : 15,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      color: isRed ? AppColors.Switcherbutton : Colors.black54,
    );
  }
}

/*---------- RESET PASSWORD PAGE TEXT STYLES ----------*/
class ResetPasswordTextStyle {
  static TextStyle resetPasswordText({bool isSize22 = false, isBold = false}) {
    return TextStyle(
      fontFamily: 'Poppins Medium',
      fontSize: isSize22 ? 22 : 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
  }
}
