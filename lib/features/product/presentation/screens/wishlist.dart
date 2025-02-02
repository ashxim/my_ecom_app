import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_state.dart';

import '../../../../core/di/di_product.dart';
import '../../../../core/themes/app_font.dart';
import '../widgets/home widget/hot_deals.dart';
import 'cart.dart';
import 'product_details.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    super.key,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
      BlocProvider.value(
        value: getIt<WishlistBloc>()..add(FetchWishlist()),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent, // Fully transparent
              elevation: 0, // Remove shadow
              title: Center(
                child: Text(
                  "My Wishlist",
                  style: AppFont.appTitle(
                    color: AppColor.principle,
                  ),
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
                    ))
              ]),
          body: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WishlistLoaded) {
                if (state.products.isEmpty) {
                  return const Center(
                      child: Text('No items in your wishlist.'));
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              thumbnail: product.thumbnail,
                              description: product.description,
                              rating: product.rating,
                            ),
                          ),
                        );
                      },
                      child: HotDeals(
                        productId: product.id,
                        title: product.title,
                        price: product.price,
                        thumbnail: product.thumbnail,
                        icon: IconButton(
                            onPressed: () {
                              context.read<WishlistBloc>().add(RemoveWishlist(
                                  productId: product.id.toString()));
                            },
                            icon: const Icon(FluentIcons.delete_12_regular)),
                      ),
                    );
                  },
                );
              } else if (state is WishlistError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    ]);
  }
}
