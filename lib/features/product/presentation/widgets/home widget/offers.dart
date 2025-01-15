import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 40,
        right: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [AppColor.principle, AppColor.blue])),
        height: screenHeight * 0.5,
        width: screenWidth * 0.8,
        child: const Center(
          child: Text(
            'offers',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
