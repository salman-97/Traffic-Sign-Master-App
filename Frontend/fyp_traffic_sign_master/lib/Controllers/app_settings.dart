// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';

void openApplicationSettings() async {
  if (Platform.isAndroid) {
    try {
      final intent = AndroidIntent(
        action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
        data: 'package:com.example.fyp_traffic_sign_master',
      );
      await intent.launch();
    } catch (e) {
      print('Erro Opening: $e');
    }
  }
}
