// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class CustomButton extends StatelessWidget {
  String name;
  CustomButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 55,
      width: 330,
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins Medium',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ]),
    );
  }
}
