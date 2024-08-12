// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:fyp_traffic_sign_master/Controllers/scan_controller.dart';
// import 'package:get/get.dart';

// class CameraView extends StatelessWidget {
//   const CameraView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: GetBuilder<ScanController>(
//           init: ScanController(),
//           builder: (controller) {
//             return controller.isCameraInitialized.value
//                 ? CameraPreview(controller.cameraController)
//                 : const Center(
//                     child: Text("LOADING PREVIEW PLEASE WAIT"),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }
