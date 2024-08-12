// ignore_for_file: file_names, use_super_parameters

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/Login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/images/Logo.png'),
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TRAFFIC SIGN MASTER',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.SplashTextcolor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Where Signs Speak',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                    //fontFamily: 'Poppins Bold',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
