// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Screens/change_password.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class Verification extends StatefulWidget {
  final String userNumber;
  const Verification({Key? key, required this.userNumber}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        // APPBARA
        appBar: AppBar(
          title: const Text(
            "Phone Verfification",
            style: TextStyle(
                fontFamily: 'Poppins Regular',
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          backgroundColor: AppColors.buttonColor,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VERIFICATION HEADING
                    Text('VERIFICATION',
                        style: ResetPasswordTextStyle.resetPasswordText(
                            isSize22: true, isBold: true)),
                    SizedBox(height: 5),

                    // VERIFICATION TEXT
                    Text.rich(
                      TextSpan(
                        text: 'We’ve send you the verification code on',
                        style: ResetPasswordTextStyle.resetPasswordText(),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' ${widget.userNumber}',
                              style: ResetPasswordTextStyle.resetPasswordText(
                                  isBold: true)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    //VERIFICATION CODE FIELD
                    PinCodeTextField(
                      appContext: context,
                      length: 5,
                      enabled: true,
                      hintCharacter: ('-'),
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 55,
                        fieldWidth: 55,
                        inactiveColor: AppColors.Verification,
                        activeColor: AppColors.Verification,
                        selectedColor: AppColors.buttonColor,
                      ),
                    ),

                    // CONTINUE BUTTON
                    Padding(
                      padding: EdgeInsets.only(left: 22, top: 25),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          // SEND BUTTON
                          return InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                SlideRightPageRoute(
                                    page: ChangePassword(userMobileNumber: widget.userNumber), slideRight: true),
                              );
                            },
                            child: Column(
                              children: [
                                isLoading
                                    ? const CircularProgressIndicator()
                                    : CustomButton(name: 'CONTINUE'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
