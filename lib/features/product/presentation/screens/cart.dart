import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/cart%20widgets/cart_items.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/cart%20widgets/checkout_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make scaffold transparent

      body: Stack(
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
          // Column for the ListView and CheckoutWidget
          Column(
            children: [
              // Add a SizedBox to account for the AppBar height
              AppBar(
                backgroundColor: Colors.transparent, // Fully transparent AppBar
                elevation: 0, // Remove shadow
                title: Center(
                  child: Text(
                    "My Shopping Cart",
                    style: AppFont.appTitle(color: AppColor.principle),
                  ),
                ),
              ),
              // ListView inside an Expanded widget
              Expanded(
                child: ListView.builder(
                  itemCount: 20, // Example item count
                  itemBuilder: (BuildContext context, int index) {
                    return const CartItems();
                  },
                ),
              ),
              // CheckoutWidget at the bottom
              const ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: CheckoutWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
