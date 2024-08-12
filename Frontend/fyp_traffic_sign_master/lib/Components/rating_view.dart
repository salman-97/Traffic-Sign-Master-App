// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fyp_traffic_sign_master/Components/colors.dart';
import 'package:fyp_traffic_sign_master/Components/custom_button.dart';
import 'package:fyp_traffic_sign_master/Components/custom_snackbar.dart';
import 'package:fyp_traffic_sign_master/Firebase_Services/user_repo.dart';
import 'package:get/get.dart';

class AppRating extends StatefulWidget {
  const AppRating({super.key});

  @override
  State<AppRating> createState() => _AppRatingState();
}

class _AppRatingState extends State<AppRating> {
  final _ratingPageController = PageController();
  var _starPosition = 190.0;
  var _rating = 0;
  var _selectedChipIndex = -1;
  bool isLoading = false;
  List<String> ratings = [
    'Algorithm',
    'App Theme',
    'Backend',
    'G.U.I',
    'Overall-Good',
    'Font Family',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), //744
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Rating Dialog
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildRatingDialog(),
                _buildThanksForRating(),
              ],
            ),
          ),

          // DONE BUTTON
          if (_selectedChipIndex != -1)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 50,
                color: AppColors.buttonColor,
                child: GestureDetector(
                  onTap: () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    // Store UserRating in Firestore
                    await UserRepo.instance
                        .storeUserRating(_rating, ratings[_selectedChipIndex]);
                    setState(() {
                      isLoading = false;
                    });

                    // Hide Dialog
                    _hideRatingDialog();

                    // Confirmation of Rating
                    CustomSnackBar.show(
                      context: Get.overlayContext!,
                      message: "Happy to hear from you 😊",
                    );
                  },
                  child: isLoading
                      ? Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : CustomButton(name: 'DONE'),
                ),
              ),
            ),

          // SKIP BUTTON
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: _hideRatingDialog,
              child: Text("SKIP"),
            ),
          ),

          // STAR RATING
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    _ratingPageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInQuad);
                    setState(() {
                      _starPosition = 30.0;
                      _rating = index + 1;
                    });
                  },
                  icon: index < _rating
                      ? Icon(Icons.star, size: 40)
                      : Icon(Icons.star_border, size: 40),
                  color: AppColors.buttonColor,
                ),
              ),
            ),
            duration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  _buildRatingDialog() {
    return Column(
      children: const [
        SizedBox(height: 70),
        Text(
          "RATE OUR PROJECT",
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 20,
            color: AppColors.buttonColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          "Help us improve! Share your thoughts by rating our Final Year Project Mobile Application.",
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            fontSize: 13,
            color: AppColors.buttonColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  _buildThanksForRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                "What Could Be Better ?",
                style: TextStyle(
                    fontFamily: 'Poppins Regular',
                    fontSize: 16,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // FEEDBACK
              Wrap(
                spacing: 3,
                alignment: WrapAlignment.center,
                children: List.generate(
                  6,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedChipIndex = index;
                      });
                    },
                    child: Chip(
                      backgroundColor: _selectedChipIndex == index
                          ? AppColors.buttonColor
                          : Colors.indigo[50],
                      label: Text(
                        ratings[index],
                        style: _selectedChipIndex != index
                            ? TextStyle(color: Colors.black, fontSize: 11)
                            : TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          replacement: Container(),
        ),
      ],
    );
  }

  _hideRatingDialog() {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
