import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class Categories extends StatelessWidget {
  final String categoryIcon;
  final String name;
  const Categories({super.key, required this.categoryIcon, required this.name});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
        mainAxisSize: MainAxisSize.min, // Avoid taking unnecessary space
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              alignment: Alignment.center, // Center text inside the Stack
              children: [
                // Blurred Background
                BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10), // Adjust blur for better performance
                  child: Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.18,
                    color: Colors.black, // Transparent overlay
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.18,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.blue.withOpacity(0.5),
                        AppColor.lightPurple.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                Image.asset(categoryIcon),
              ],
            ),
          ),

          const SizedBox(height: 8), // Add spacing between the box and the text
          SizedBox(
            width:
                screenWidth * 0.3, // Ensure text doesn't exceed the box width
            child: Text(
              name,
              maxLines: 3, // Limit the text to 2 lines
              textAlign: TextAlign.center, // Center the text horizontally
              overflow: TextOverflow.clip, // Add ellipsis if text overflows
              style: AppFont.widgetTitle(color: AppColor.Black, fontSize: 14),
            ),
          ),
        ]);
  }
}
