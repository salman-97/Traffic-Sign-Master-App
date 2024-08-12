// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';

class AppPoliciesAndLicenses extends StatefulWidget {
  const AppPoliciesAndLicenses({super.key});

  @override
  State<AppPoliciesAndLicenses> createState() => _AppPoliciesAndLicensesState();
}

class _AppPoliciesAndLicensesState extends State<AppPoliciesAndLicenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
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
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 20),
                child: Column(
                  children: [
                    Text.rich(
                      // PRIVACY POLICY CONTENT
                      TextSpan(
                        text: 'Privacy Policy for ',
                        style: AppPolicyTextStyle.appPolicyBody(
                            isColorBlack: true),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'TRAFFIC SIGN MASTER',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text: '\n\nDeveloper ',
                          ),
                          TextSpan(
                              text: ' © Muhammad Salman',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true,
                                  isBold: true,
                                  isColorBlack: true)),
                          const TextSpan(
                            text: '\n\nLast Updated',
                          ),
                          TextSpan(
                              text: ' February 23, 2024.',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true,
                                  isBold: true,
                                  isColorBlack: true)),
                          TextSpan(
                              text: '\n\n1. INTRODUCTION',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text:
                                '\nWelcome we respect your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and disclose your data when you use our mobile application.',
                          ),
                          TextSpan(
                              text: "\n\n2. INFORMATION COLLECTION",
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text:
                                "\nWhile using our App, we may collect personal information that can be used to identify you, such as your name, email address, and other relevant details. We collect this information when you voluntarily provide it, such as when you register an account or use certain features of the App."
                                "\nWe may also collect non-personal information, such as device information, app usage data, and other analytics to improve the functionality and performance of the application.",
                          ),
                          TextSpan(
                              text: "\n\n3. INFORMATION USAGE",
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text: "\nWe may use your personal information to:"
                                "\n Provide and maintain the application."
                                " Improve, personalize, and expand features."
                                " Communicate with you, respond to your inquiries, and provide support."
                                " Send you updates, newsletters, and promotional materials (if you opt-in)."
                                "\n Non-personal information is used for analytical purposes to understand how users interact with the application, improve its performance, and enhance user experience.",
                          ),
                          TextSpan(
                              text: '\n\n4. DATA SHARING',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text:
                                '\nWe do not sell, trade, or rent your personal information to third parties. We may share your information with trusted third parties who assist us in operating the App, conducting our business, or servicing you, as long as those parties agree to keep this information confidential.',
                          ),
                          TextSpan(
                              text: '\n\n5. SECURITY',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text:
                                '\nWe take reasonable measures to protect your personal information from unauthorized access, use, or disclosure.',
                          ),
                          TextSpan(
                              text: '\n\n6. CHANGES TO POLICY',
                              style: AppPolicyTextStyle.appPolicyBody(
                                  isSize16: true, isBold: true)),
                          const TextSpan(
                            text:
                                '\nWe reserve the right to update our Privacy Policy at any time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                          ),
                          const TextSpan(
                            text:
                                '\n\nBy using the App, you agree to the terms outlined in this Privacy Policy.\n',
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
