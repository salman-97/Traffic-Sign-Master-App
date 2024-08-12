// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/page_tranisition.dart';
import 'package:fyp_traffic_sign_master/Screens/output_page.dart';
import 'package:image_cropper/image_cropper.dart';

class CropImageScreen extends StatefulWidget {
  final String imagePath;

  CropImageScreen({super.key, required this.imagePath});

  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  late Future<void> _cropImageFuture;

  @override
  void initState() {
    super.initState();
    _cropImageFuture = _cropImage();
  }

  Future<void> _cropImage() async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: widget.imagePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Sign',
          toolbarColor: AppColors.buttonColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
          hideBottomControls: true,
        ),
      ],
    );

    if (croppedImage == null) return;

    Navigator.pushReplacement(
      context,
      SlideRightPageRoute(
        page: OutputPage(selectedImagePath: croppedImage.path),
        slideRight: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Image'),
      ),
      body: FutureBuilder<void>(
        future: _cropImageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Crop is complete, you can show any UI or message here
            return Center(
              child: Text('Crop complete'),
            );
          } else {
            // Crop is in progress, you can show a loading indicator
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// Your SlideRightPageRoute and OutputPage remains the same
