import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/bubble_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          BubbleBackground(),
          Center(
            child: ClipRect(
              // Clip the BackdropFilter to only affect the square area
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(
                        color: AppColor.white, // Set your border color here
                        width: 2.0, // Set the width of the border here
                      ),
                    ),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.9,
                  // A semi-transparent color overlay so you can see the blur effect

                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
