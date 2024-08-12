// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_auth.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:fyp_traffic_sign_master/Controllers/login_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/signup_controller.dart';
import 'package:fyp_traffic_sign_master/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:fyp_traffic_sign_master/Components/custom_navbar.dart';
import 'package:fyp_traffic_sign_master/Controllers/tab_provider.dart';
import 'package:fyp_traffic_sign_master/Screens/login_page.dart';
import 'package:fyp_traffic_sign_master/Screens/splashscreen.dart';
import "package:get/get.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //cameras = await availableCameras();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value){
        Get.put(SignUpController());
        Get.put(LoginController());
        Get.put(UserRepo());
        Get.put(UserAuthentication());
        Get.put(ProfileController());
        Get.put(ProfileImageController());
      });
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(ChangeNotifierProvider(
    create: (context) => TabIndexProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/SplashScreen',
      routes: {
        '/SplashScreen': (context) => SplashScreen(),
        '/Login': (context) => LoginPage(),
        '/Googlenavbar': (context) => CustomNavBar(),
      },
    );
  }
}

