import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class FutureFunctionality extends StatefulWidget {
  const FutureFunctionality({super.key});

  @override
  State<FutureFunctionality> createState() => _FutureFunctionality();
}

class _FutureFunctionality extends State<FutureFunctionality> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Future Feature",
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
      body: const Center(
        child: Text(
          'FUTURE FUNCTIONALITY',
          style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
