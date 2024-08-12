// ignore_for_file: must_be_immutable, file_names, prefer_const_constructors, use_build_context_synchronously, use_super_parameters, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_auth.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/rating_view.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/update_profile.dart';
import 'package:fyp_traffic_sign_master/Screens/about_page.dart';
import 'package:fyp_traffic_sign_master/Screens/contact_form.dart';
import 'package:fyp_traffic_sign_master/Screens/guide_page.dart';
import 'package:fyp_traffic_sign_master/Screens/output_page.dart';
import 'package:fyp_traffic_sign_master/Screens/settings_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp_traffic_sign_master/Controllers/profile_image_controller.dart';
import 'package:fyp_traffic_sign_master/Controllers/tab_provider.dart';
import '../Components/page_tranisition.dart';
import 'package:image_cropper/image_cropper.dart';

// GLOBAL VARIABLES FOR HOMEPAGE
final pController = Get.put(ProfileController());
final updController = Get.put(UpdateProfileController());
final profileImageController = Get.find<ProfileImageController>();
ImagePicker profileImagePicker = ImagePicker();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: NavigationDrawer(),

      // USER NAME IN APP BAR FROM FIREBASE
      appBar: AppBar(
        title: Obx(
          () {
            if (pController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return Text("Hi, ${pController.userDetails.value.fullname}",
                  style: HomePageTextStyles.userNameText(white: true));
            }
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttonColor,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.contact_support_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  SlideRightPageRoute(page: ContactUsPage(), slideRight: true));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
          ),

          //Camera Container
          InkWell(
            onTap: () {
              CustomSnackBar.show(
                  context: Get.overlayContext!,
                  message: "Realtime Traffic Sign Detection in Progress ☕︎");
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => CameraView(),
              //   ),
              // );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.buttonColor.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/images/Camera1.png'),
                    height: 75,
                    width: 75,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('CAMERA',
                      style: HomePageTextStyles.baseText(bold: true)),
                  SizedBox(
                    height: 3,
                  ),
                  Text('Real-Time Recognition',
                      style: HomePageTextStyles.baseText(bold: false)),
                ],
              ),
            ),
          ),
          //------------------
          const SizedBox(
            height: 15,
          ),

          //Gallery Container
          InkWell(
            onTap: () {
              openGallery(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.buttonColor.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/images/Upload.png'),
                    height: 75,
                    width: 75,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('GALLERY',
                      style: HomePageTextStyles.baseText(bold: true)),
                  SizedBox(
                    height: 3,
                  ),
                  Text('Select a Sign',
                      style: HomePageTextStyles.baseText(bold: false)),
                ],
              ),
            ),
          ),
          //------------------
          const SizedBox(
            height: 15,
          ),

          //Guide Container
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                SlideRightPageRoute(page: Guidepage(), slideRight: true),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.buttonColor.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/images/Guide1.png'),
                    height: 75,
                    width: 75,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('GUIDE', style: HomePageTextStyles.baseText(bold: true)),
                  SizedBox(
                    height: 3,
                  ),
                  Text('Traffic Signs',
                      style: HomePageTextStyles.baseText(bold: false)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DRAWER
class NavigationDrawer extends StatelessWidget {
  final ProfileImageController profilePicController = Get.find();
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      );
}

// DRAWER HEADER
Widget buildHeader(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture in Drawer
          Obx(
            () {
              final profileImagePath =
                  Get.find<ProfileImageController>().profileImagePath;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.buttonColor.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white12,
                  backgroundImage: profileImagePath.isNotEmpty
                      ? CachedNetworkImageProvider(profileImagePath.value)
                      : AssetImage('assets/images/profile.png')
                          as ImageProvider<Object>,
                ),
              );
            },
          ),

          SizedBox(height: 20),

          // USER NAME IN DRAWER
          Obx(
            () => Text(pController.userDetails.value.fullname,
                style: HomePageTextStyles.userNameText(
                    white: false, size20: true)),
          ),

          // TAGLINE IN DRAWER
          Obx(
            () => Text('« ${pController.userDetails.value.tagline} »',
                style: HomePageTextStyles.baseText(
                    bold: false, size15: true, red: true, italic: true)),
          ),
        ],
      ),
    );

// DRAWER MENU ITEMS
Widget buildMenuItems(BuildContext context) => Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // MY PROFILE
            ListTile(
              leading: const Icon(
                Icons.person,
                color: AppColors.drawerIcon,
              ),
              title: const Text('My Profile',
                  style: HomePageTextStyles.drawerText),
              onTap: () {
                final tabProvider =
                    Provider.of<TabIndexProvider>(context, listen: false);
                tabProvider.updateSelectedIndex(3);
                Navigator.pop(context);
              },
            ),

            // VIOLATION LOG
            ListTile(
              leading: const Icon(
                Icons.local_police_outlined,
                color: AppColors.drawerIcon,
              ),
              title: const Text('Violation Log',
                  style: HomePageTextStyles.drawerText),
              onTap: () {
                CustomSnackBar.show(
                    context: Get.overlayContext!,
                    message: "Application Feature in Progress ☕︎");
              },
            ),

            // TRAFFIC ALERTS
            ListTile(
              leading: const Icon(
                Icons.warning_sharp,
                color: AppColors.drawerIcon,
              ),
              title: const Text('Traffic Alerts',
                  style: HomePageTextStyles.drawerText),
              onTap: () {
                final tabProvider =
                    Provider.of<TabIndexProvider>(context, listen: false);
                tabProvider.updateSelectedIndex(2);
                Navigator.pop(context);
              },
            ),

            // SIGNS GUIDE
            ListTile(
              leading: Transform.flip(
                flipY: true,
                child: const Icon(
                  Icons.report_gmailerrorred,
                  color: AppColors.drawerIcon,
                  size: 26,
                ),
              ),
              title: const Text('Signs Guide',
                  style: HomePageTextStyles.drawerText),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightPageRoute(
                      page: const Guidepage(), slideRight: true),
                );
              },
            ),

            // ABOUT US
            ListTile(
              leading: const Icon(
                Icons.emoji_emotions,
                color: AppColors.drawerIcon,
              ),
              title: const Text('About Devs',
                  style: HomePageTextStyles.drawerText),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightPageRoute(
                    page: AboutUsPage(),
                    slideRight: true,
                  ),
                );
              },
            ),

            // SETTINGS
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                color: AppColors.drawerIcon,
              ),
              title:
                  const Text('Settings', style: HomePageTextStyles.drawerText),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightPageRoute(page: SettingsPage(), slideRight: true),
                );
              },
            ),

            // RATE APP
            ListTile(
              leading: const Icon(
                Icons.thumb_up,
                color: AppColors.drawerIcon,
              ),
              title: const Text('Rate Our App',
                  style: HomePageTextStyles.drawerText),
              onTap: () {
                Navigator.of(context).pop();
                openRatingDialog(context);
              },
            ),

            // LOGOUT
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.drawerIcon,
              ),
              title:
                  const Text('Sign Out', style: HomePageTextStyles.drawerText),
              onTap: () {
                UserAuthentication.instance.logout();
              },
            ),
          ],
        ),
      ],
    );

// FUNCTION TO OPEN GALLERY
Future<void> openGallery(BuildContext context) async {
  final imagePicker = ImagePicker();
  final imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);

  if (imagePicked == null) return;

  final croppedImage = await ImageCropper().cropImage(
    sourcePath: imagePicked.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: AppColors.buttonColor,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
        hideBottomControls: true,
      ),
    ],
  );

  if (croppedImage == null) return;

  Navigator.push(
    context,
    SlideRightPageRoute(
        page: OutputPage(selectedImagePath: croppedImage.path),
        slideRight: true),
  );
}

// FUNCTION TO OPEN RATING DIALOG
void openRatingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: AppRating(),
        );
      });
}
