// // ignore_for_file: prefer_const_declarations, avoid_print

// import 'dart:developer';

// import 'package:camera/camera.dart';
// import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ScanController extends GetxController {
//   late CameraController cameraController;
//   late List<CameraDescription> cameras;
//   var isCameraInitialized = false.obs;
//   var detectedLabel = RxString("");
//   var cameraCount = 0;

//   @override
//   void onInit() async {
//     super.onInit();
//     initCamera();
//     initTFLite();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     cameraController.dispose();
//   }

//   initCamera() async {
//     if (await Permission.camera.request().isGranted) {
//       cameras = await availableCameras();

//       cameraController = CameraController(cameras[0], ResolutionPreset.max,
//           imageFormatGroup: ImageFormatGroup.jpeg);
//       await cameraController.initialize().then((value) {
//         cameraController.startImageStream((image) {
//           //cameraCount++;
//           if (cameraCount % 10 == 0) {
//             signDetector(image);
//           }
//           update();
//         });
//       });
//       isCameraInitialized(true);
//       update();
//     } else {
//       CustomSnackBar.show(
//         context: Get.overlayContext!,
//         message: "PERMISSION DENIED",
//       );
//     }
//   }

//   initTFLite() async {
//     await Tflite.loadModel(
//       model: "assets/ML_models/model.tflite",
//       labels: "assets/ML_models/labels.txt",
//       isAsset: true,
//       numThreads: 1,
//       useGpuDelegate: false,
//     );
//   }

//   signDetector(CameraImage image) async {
//     var detector = await Tflite.runModelOnFrame(
//       bytesList: image.planes.map((e) {
//         return e.bytes;
//       }).toList(),
//       asynch: true,
//       imageHeight: image.height,
//       imageWidth: image.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       numResults: 1,
//       rotation: 90,
//       threshold: 0.4,
//     );
//     if (detector != null) {
//       log("Result is $detector");
//     }
//   }
// }


// //  var x, y, w, h = 0.0;
// // var label = "";


// //late Interpreter interpreter;

// //await initModel();
// //  Future<void> initModel() async {
//   //   try {
//   //     interpreter =
//   //         await Interpreter.fromAsset('assets/ML_models/model.tflite');
//   //   } catch (e) {
//   //     print("Failed to Load Model: $e");
//   //   }
//   // }


//   // Future<void> runInference(CameraImage image) async {
//   //   var input = image.planes.map((plane) {
//   //     return plane.bytes;
//   //   }).toList();

//   //   var output = List.filled(1 * 42, 0).reshape([1, 42]);
//   //   interpreter.run(input, output);

//   //   var outputTensors = interpreter.getOutputTensor(0);
//   //   List<Map<String, dynamic>> results = processOutput(outputTensors);

//   //   if (results.isNotEmpty) {
//   //     String label = results[0]['label'];
//   //     double confidence = results[0]['confidence'];

//   //     if (confidence > 0.7) {
//   //       detectedLabel.value = label;
//   //     } else {
//   //       detectedLabel.value = "UNKNOWN";
//   //     }
//   //   }
//   // }

//   // List<Map<String, dynamic>> processOutput(Tensor outputTensor) {
//   //   final int labelIndex = 0;
//   //   final int confidenceIndex = 1;

//   //   final List<int> labels = outputTensor.data.cast<int>().toList();
//   //   final List<double> confidences = outputTensor.data.cast<double>().toList();
//   //   return [
//   //     {
//   //       'label': labels[labelIndex],
//   //       'confidence': confidences[confidenceIndex],
//   //     }
//   //   ];
//   // }

//   // Use RxString for detectedLabel