import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_state.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/cart%20widgets/cart_items.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/cart%20widgets/checkout_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      context.read<CartBloc>().add(LoadCartEvent(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double price;
    final double discountPercentage;
    final int quantity;
    return Scaffold(
        backgroundColor: Colors.transparent, // Make scaffold transparent

        body: Stack(children: [
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

              Expanded(
                child:
                    BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                  if (state is CartLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is CartLoaded) {
                    return ListView.builder(
                        itemCount: state.cartItems.length, // Example item count
                        itemBuilder: (BuildContext context, int index) {
                          final item = state.cartItems[index];

                          return CartItems(
                            discountPercentage: item.discountPercentage,
                            productId: item.productId,
                            id: item.id,
                            price: item.price,
                            quantity: item.quantity,
                            thumbnail: item.thumbnail,
                            title: item.title,
                          );
                        });
                  } else if (state is CartError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const Center(child: Text('Cart is empty!'));
                }),
              ),

              // CheckoutWidget at the bottom
              BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                double subtotal = 0.0;
                int totalQuantity = 0;
                // For this example, let’s assume a fixed discount of 10%
                double discountPercentage = 10.0;

                if (state is CartLoaded) {
                  for (var item in state.cartItems) {
                    subtotal += (item.price ?? 0.0) * item.quantity;
                    totalQuantity += item.quantity;
                    discountPercentage += item.discountPercentage;
                  }
                }
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CheckoutWidget(
                    price: subtotal,
                    discountPercentage: discountPercentage,
                    quantity: totalQuantity,
                  ),
                );
              })
            ],
          ),
        ]));
  }
}
