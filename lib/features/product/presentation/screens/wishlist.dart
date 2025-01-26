import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/hot_deals.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

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
              "Wishlist",
              style: AppFont.appTitle(color: AppColor.principle),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetails(
                          rating: 4.5,
                          title: 'Sample Product',
                          thumbnail: 'assets/sample_thumbnail.png',
                          description: 'This is a sample product description',
                          price: 99.99,
                          discountPercentage: 10,
                        ),
                      ));
                },
                child: HotDeals(
                  title: 'Sample Product',
                  price: 99.99,
                  thumbnail: 'assets/sample_thumbnail.png',
                  icon: Icons.delete_outline_rounded,
                )),
          ),
        ),
      ),
    ]);
  }
}
