import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_state.dart';
import 'package:my_ecom_app/features/product/presentation/screens/cart.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String thumbnail;
  final String description;
  final double rating;
  final double price;
  final double? discountPercentage;
  final int id;

  const ProductDetails({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.price,
    this.discountPercentage,
    required this.rating,
    required this.id,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final SupabaseClient client = Supabase.instance.client;
    final String? userId = client.auth.currentUser?.id;
    String myprice = widget.price.toString();
    String mydiscount = widget.price.toString();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double rating = widget.rating;

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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                icon: const Icon(
                  size: 28,
                  Icons.shopping_bag_outlined,
                  color: AppColor.principle,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Product Image
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.thumbnail, // Replace with actual image URL
                      height: screenHeight * 0.45,
                      width: screenWidth * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content area
                Container(
                  height: screenWidth,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColor.principle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                widget.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: AppFont.widgetTitle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RatingStars(
                          value: rating,
                          onValueChanged: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                          starCount: 5,
                          starSize: 10,
                          starSpacing: 2,
                          starColor: Colors.amber,
                          starOffColor: Colors.grey,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.description,
                          style: AppFont.normalText(
                            color: Colors.white,
                            fontSize: 18,
                          ),

                          // Add more content here
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "\$$myprice",
                                style: AppFont.widgetTitle(
                                    color: AppColor.blue, fontSize: 25),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  maximumSize: WidgetStatePropertyAll(
                                    Size.lerp(
                                      const Size(200, 50),
                                      const Size(200, 50),
                                      0.5,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Default quantity when adding to cart
                                  if (userId != null) {
                                    // User is authenticated, add to cart
                                    context.read<CartBloc>().add(AddToCartEvent(
                                          userId: userId,
                                          productId: widget.id,
                                          title: widget.title,
                                          price: widget.price,
                                          thumbnail: widget.thumbnail,
                                          quantity: 1,
                                        ));
                                  } else {
                                    // User is not authenticated, show a login prompt
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please log in to add to cart.')),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  FluentIcons.shopping_bag_16_filled,
                                  color: AppColor.Black,
                                  size: 20,
                                ),
                                label: Text(
                                  'Add to Cart',
                                  style: AppFont.widgetTitle(
                                      color: AppColor.Black, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        )
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
