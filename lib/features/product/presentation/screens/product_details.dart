import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                AppColor.Grey,
                Color(0xFF007AFF),
                AppColor.white,
              ],
            ),
          ),
        ),
        // Scaffold with transparent AppBar
        Scaffold(
          backgroundColor: Colors.transparent, // Make scaffold transparent
          appBar: AppBar(
            backgroundColor: Colors.transparent, // Fully transparent
            elevation: 0, // Remove shadow
            title: Center(
              child: Text(
                "Product Details",
                style: AppFont.appTitle(color: AppColor.principle),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  size: 28,
                  Icons.shopping_bag_outlined,
                  color: AppColor.principle,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Product Image
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://icon2.cleanpng.com/20180422/ocw/kisspng-apple-watch-pebble-smartwatch-wearable-technology-apple-watch-5adc170f2ac9d2.9128155815243732631753.jpg", // Replace with actual image URL
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content area
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColor.principle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product name',
                          style: AppFont.widgetTitle(
                              color: AppColor.Grey, fontSize: 35),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "n today’s rapidly evolving world, innovation has become the cornerstone of progress, shaping industries, societies, and the way we live our lives. From technology to healthcare, education to business, the relentless pursuit of innovation drives humanity toward solutions to some of its most pressing challenges."
                          "Innovation is not merely about inventing new things; it is about reimagining existing systems, processes, and ideas to make them more effective, efficient, and sustainable. Take, for example, the world of technology. Over the past few decades, we have witnessed transformative changes—from the advent of personal computers to the rise of smartphones, artificial intelligence, and cloud computing. These innovations have not only revolutionized how businesses operate but also redefined communication, connectivity, and convenience in our personal lives."
                          "Healthcare is another domain where innovation has made a profound impact. Advances in medical technology, such as robotic surgeries, telemedicine, and genetic engineering, have saved countless lives and improved the quality of life for millions. Diseases that were once considered fatal can now be managed or cured, thanks to the innovative approaches of researchers and medical professionals. The COVID-19 pandemic, for instance, underscored the importance of rapid innovation, as scientists around the globe raced to develop vaccines in record time, demonstrating the power of collaboration and technology.",
                          style: AppFont.normalText(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        // Add more content here
                        const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '80 £',
                                style: AppFont.widgetTitle(
                                    color: AppColor.blue, fontSize: 35),
                              ),
                              InkWell(
                                onTap: () {},
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      children: [
                                        // Blurred Background
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10,
                                              sigmaY: 10), // Blur effect
                                          child: Container(
                                            color: Colors
                                                .transparent, // Background transparency
                                          ),
                                        ),

                                        // Foreground with semi-transparent color
                                        Container(
                                            width: screenWidth * 0.4,
                                            height: screenHeight * 0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColor.blue.withOpacity(
                                                  0.2), // Semi-transparent blue
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'Add To Cart',
                                                  style: AppFont.widgetTitle(
                                                      color: AppColor.white,
                                                      fontSize: 20),
                                                ),
                                                Icon(
                                                    Icons.shopping_bag_outlined)
                                              ],
                                            ))
                                      ],
                                    )),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
