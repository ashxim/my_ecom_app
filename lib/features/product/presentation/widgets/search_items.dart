import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class SearchItems extends StatelessWidget {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  const SearchItems(
      {super.key,
      required this.id,
      required this.title,
      required this.thumbnail,
      required this.price});

  @override
  Widget build(BuildContext context) {
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
              width: screenWidth * 0.9,
              height: screenHeight * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.principle
                    .withOpacity(0.7), // Semi-transparent blue
              ),
              child: Row(
                children: [
                  // Product Image
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.network(
                      thumbnail,
                      height: screenHeight * 0.18,
                      width: screenWidth * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Product Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            title,
                            maxLines: 3,
                            style: AppFont.widgetTitle(
                                color: AppColor.white, fontSize: 18),
                          ),
                          Text(
                            price.toString(),
                            style: AppFont.widgetTitle(
                                color: AppColor.blue, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: AppColor.white,
                            size: 25, // Adjusted size
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            color: AppColor.white,
                            size: 25, // Adjusted size
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
