import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              "My Shoping Cart",
              style: AppFont.appTitle(color: AppColor.principle),
            ),
          ),
        ),
      ),
      ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return;
        },
      ),
    ]);
  }
}
