// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, prefer_const_declarations, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fyp_traffic_sign_master/Styles/page_textStyles.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';

class OutputPage extends StatefulWidget {
  final String selectedImagePath;
  OutputPage({super.key, required this.selectedImagePath});
  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  FlutterTts flutterTts = FlutterTts();
  String selectedLanguage = "English (US)";
  String predictedSign = '';
  String signProbability = '';
  bool isClassifying = false;

  // INITIALIZING THE DEFAULT LANGUAGE WHEN PAGE LOADS
  @override
  void initState() {
    super.initState();
    _setVoice();
  }

  @override
  Widget build(BuildContext context) {
    print('Selected Image Path: ${widget.selectedImagePath}');
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.buttonColor,
        title: Text(
          "Sign Classification",
          style: TextStyle(
              fontFamily: 'Poppins Regular',
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 12, right: 12),
        child: Center(
          child: Column(
            children: [
              // HEADING TEXT
              Text('TRAFFIC SIGN DETECTION',
                  style: OutputPageTextStyle.headerText(
                      isSize22: true, isBold: true)),

              // HEADING SUB TEXT
              Text("Recognize & Hear The Detected Sign",
                  style: OutputPageTextStyle.headerText(
                      isBlack: false, isItalic: true)),
              SizedBox(height: 15),

              // CONTAINER HOLDING SIGN
              Container(
                height: 280,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.buttonColor.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.file(
                  File(widget.selectedImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 25),

              // DETECT BUTTON
              InkWell(
                onTap: () async {
                  await detectSign();
                },
                child: CustomButton(name: 'DETECT THE SIGN'),
              ),
              const SizedBox(height: 25),

              // BUTTON LOADING
              if (isClassifying)
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.Switcherbutton),
                )

              // PREDICTION LOGIC | TEXT-TO-SPEECH BUTTON | LANGUAGE SELECTION
              else if (predictedSign.isNotEmpty)
                Column(
                  children: [
                    Text(
                      'SIGN NAME \n 【 $predictedSign 】',
                      style: OutputPageTextStyle.bodyText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    if (predictedSign != 'No Sign Identified')
                      Text(
                        'CONFIDENCE \n ⌠ $signProbability ⌡',
                        style: OutputPageTextStyle.bodyText,
                        textAlign: TextAlign.center,
                      ),

                    // TEXT-TO-SPEECH BUTTON
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FloatingActionButton(
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: AppColors.white,
                        onPressed: _speakText,
                        child: Icon(Icons.volume_up),
                      ),
                    ),

                    // LANGUAGE DROPDOWN
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 20),
                      child: DropdownButton<String>(
                        value: selectedLanguage,
                        onChanged: (String? newLang) {
                          setState(() {
                            selectedLanguage = newLang!;
                            _setVoice();
                          });
                        },
                        items: <String>['English (US)', 'English (PAK)']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // FUNCTION TO DETECT INPUT SIGN USING API
  Future<void> detectSign() async {
    setState(() {
      isClassifying = true;
    });
    try {
      //final url = 'http://10.0.2.2:5000/predict';            // for testing on android emulator
      //final url = 'http://192.168.0.108:5000/predict';      // for testing on my mobile device on same network

      // live on ngrok terminal but need the machine to be active and api running
      final url = 'https://next-finally-sculpin.ngrok-free.app/predict_image';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
          await http.MultipartFile.fromPath('File', widget.selectedImagePath));
      var response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(await response.stream.bytesToString());
        var prediction = jsonResponse['Prediction'];
        var confidence = jsonResponse['Confidence'];

        setState(() {
          predictedSign = prediction;
          signProbability = confidence.toStringAsFixed(2);
        });
      } else {
        throw 'Error in Response: ${response.reasonPhrase}';
      }
    } catch (error) {
      throw 'Error Occured in classifySign Method: $error';
    } finally {
      await Future.delayed(Duration(milliseconds: 800));
      setState(() {
        isClassifying = false;
      });
    }
  }

  // FUNCTION TO SET VOICE
  Future<void> _setVoice() async {
    if (selectedLanguage == 'English (PAK)') {
      await flutterTts
          .setVoice({"name": "ur-pk-x-urm-local", "locale": "ur-PK"});
    } else if (selectedLanguage == 'English (US)') {
      await flutterTts
          .setVoice({"name": "en-us-x-iom-local", "locale": "en-US"});
    }
  }

  // FUNCTION FOR TEXT TO SPEECH
  void _speakText() async {
    await flutterTts.speak(predictedSign);
  }
}
