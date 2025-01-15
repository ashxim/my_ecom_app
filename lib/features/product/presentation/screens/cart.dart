import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/cart%20widgets/cart_items.dart';

import 'package:my_ecom_app/features/product/presentation/widgets/cart%20widgets/checkout_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
                Color(0xff0ff007aff),
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
                "My Shopping Cart",
                style: AppFont.appTitle(color: AppColor.principle),
              ),
            ),
          ),
          body: Column(
            children: [
              // ListView inside an Expanded widget
              Expanded(
                child: ListView.builder(
                  itemCount: 6, // Example item count
                  itemBuilder: (BuildContext context, int index) {
                    return const CartItems();
                  },
                ),
              ),
            ],
          ),
        ),
        // Positioned container at the bottom
        Positioned(
            bottom: 0, // Position at the bottom of the screen
            left: 0, // Align with the left edge
            right: 0, // Align with the right edge
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: CheckoutWidget()))
      ],
    );
  }
}
