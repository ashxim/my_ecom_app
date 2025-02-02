import 'dart:ui'; // For ImageFilter

import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class HotDeals extends StatelessWidget {
  final String thumbnail;
  final String title;
  final double price;

  final IconButton icon;
  final int productId;
  const HotDeals({
    super.key,
    required this.icon,
    required this.thumbnail,
    required this.title,
    required this.price,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    String myprice = price.toString();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Blurred Background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
              child: Container(
                color: Colors.transparent, // Background transparency
              ),
            ),

            // Foreground with semi-transparent color
            Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.principle
                    .withOpacity(0.5), // Semi-transparent blue
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    thumbnail,
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.3,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Use Flexible or Expanded for the Column
                        Flexible(
                          flex: 4, // Adjust the flex value as needed
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the start
                            children: [
                              Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: AppFont.normalText().small(
                                  fontSize: 16,
                                  color: AppColor.white,
                                ),
                              ),
                              Text(
                                "\$$myprice",
                                overflow: TextOverflow.visible,
                                style: AppFont.widgetTitle()
                                    .large(fontSize: 15, color: AppColor.Black),
                              ),
                            ],
                          ),
                        ),

                        Flexible(
                          flex: 2, // Adjust the flex value as needed
                          child: IconButton(
                            onPressed: () {},
                            icon: IconButton(
                              onPressed: () {},
                              icon: icon,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
