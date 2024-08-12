// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  String name;
  final String imagePath;
  SocialAuthButton({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Image.asset(
              imagePath,
              height: 26,
              width: 26,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF120D26),
                    fontSize: 14,
                    fontFamily: 'Poppins Medium',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
