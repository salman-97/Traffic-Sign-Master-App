// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/Exceptions/network_exception.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:get/get.dart';

class InternetConnectivity {
  static Future<void> checkInternet() async {
    if (!(await isInternetConnected())) {
      throw const NoNetwork();
    }
  }

  static Future<bool> isInternetConnected() async {
    var conResult = await Connectivity().checkConnectivity();
    return conResult != ConnectivityResult.none;
  }

  static Future<void> noInternetSnackBar() async {
    CustomSnackBar.show(
        context: Get.overlayContext!,
        message: 'ALERT ! No Internet Connection. Please Check Network');
  }
}
