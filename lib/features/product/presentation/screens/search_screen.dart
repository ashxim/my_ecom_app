import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/search_items.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      // Gradient background
      Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
            AppColor.Grey,
            Color(0xff0ff007aff),
            AppColor.white
          ]))),
      // Scaffold with transparent AppBar
      Scaffold(
        backgroundColor: Colors.transparent, // Make scaffold transparent
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Fully transparent
          elevation: 0, // Remove shadow
          title: Center(
            child: Text(
              "Search",
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
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Semi-transparent background
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Search on your product ...',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                            ),
                            border: InputBorder.none,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(),
                                ));
                          },
                          child: SearchItems());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
