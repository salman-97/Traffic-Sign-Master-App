// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class CameraDetection extends StatefulWidget {
//   const CameraDetection({super.key});

//   @override
//   State<CameraDetection> createState() => _CameraDetectionState();
// }

// class _CameraDetectionState extends State<CameraDetection> {
//   final modelPath = "assets/ML_models/yolo_metadata.tflite";
//   late CameraController _controller;
//   late List<CameraDescription> cameras;
//   bool isDetecting = false;

//   late Interpreter interpreter;
//   late Tensor inputTensor;
//   late Tensor outputTensor;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//     setupCamera();
//   }

//   Future<void> loadModel() async {
//     interpreter =
//         await Interpreter.fromAsset(modelPath, options: InterpreterOptions());
//     inputTensor = interpreter.getInputTensors().first;
//     outputTensor = interpreter.getOutputTensors().first;
//     TensorBuf
//   }

//   Future<void> loadLabels() async {}

//   Future<void> setupCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(cameras[0], ResolutionPreset.medium);
//     await _controller.initialize();
//     if (!mounted) {
//       return;
//     }
//     setState(() {});
//     _controller.startImageStream((CameraImage image) {
//       if (!isDetecting) {
//         isDetecting = true;
//         detectObjects(image);
//       }
//     });
//   }

//   Future<void> detectObjects(CameraImage image) async {
//     try {
//       List<dynamic> recognitions = await Tflite.detectObjectOnFrame(
//         bytesList: image.planes.map((plane) => plane.bytes).toList(),
//         model: "SSDMobileNet",
//         imageHeight: image.height,
//         imageWidth: image.width,
//         imageMean: 127.5,
//         imageStd: 127.5,
//         numResultsPerClass: 1,
//         threshold: 0.2,
//       );

//       // Process the detection results as needed
//       // ...
//     } catch (e) {
//       print("Error during object detection: $e");
//     } finally {
//       isDetecting = false;
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     Tflite.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return Container();
//     }
//     return AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: CameraPreview(_controller),
//     );
//   }
// }

// https://github.com/am15h/object_detection_flutter/blob/master/install.bat