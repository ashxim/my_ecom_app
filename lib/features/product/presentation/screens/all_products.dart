import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_event.dart';
import 'package:my_ecom_app/features/product/presentation/screens/cart.dart';
import '../../../../core/themes/app_font.dart';
import '../Bloc/product/product_bloc.dart';
import '../Bloc/product/product_state.dart';
import '../widgets/home widget/hot_deals.dart';
import 'product_details.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

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
              AppColor.white,
            ],
          ),
        ),
      ),
      // Scaffold with transparent AppBar
      Scaffold(
        backgroundColor: Colors.transparent, // Make scaffold transparent
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              "All products",
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
                  ),
                );
              },
              icon: const Icon(
                size: 28,
                Icons.shopping_bag_outlined,
                color: AppColor.principle,
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              id: product.id,
                              rating: product.rating,
                              description: product.description,
                              title: product.title,
                              price: product.price,
                              thumbnail: product.thumbnail,
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
                              context.read<WishlistBloc>().add(AddToWishlist(
                                  productId: product.id.toString()));
                            },
                            icon: const Icon(Icons.favorite_border_outlined)),
                      ),
                    );
                  },
                ),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('something went wrong'));
            }
          },
        ),
      ),
    ]);
  }
}
