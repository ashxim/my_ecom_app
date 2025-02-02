import 'package:flutter/material.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_state.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_state.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_event.dart';
import 'package:my_ecom_app/features/product/presentation/screens/all_products.dart';
import 'package:my_ecom_app/features/product/presentation/screens/cart.dart';
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/categories.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/hot_deals.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/offers.dart';

import '../../../../core/dummy_data/categories.dart';
import 'product_by_categorie.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _refreshData(BuildContext context) async {
    double screenHeight = MediaQuery.of(context).size.height;
    // Simulate refreshing data
    await Future.delayed(const Duration(seconds: 2));

    // Refresh categories
    context.read<CategoriesBloc>().add(FetchCategories());

    // Refresh hot deals
    context.read<HotDealsBloc>().add(FetchHotDeals());
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "ClickShop",
            style: AppFont.appTitle(color: AppColor.principle),
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
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await _refreshData(context);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // offers widget
                  width: double.maxFinite,
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => const Offers(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories',
                          style: AppFont.widgetTitle(
                              color: AppColor.principle, fontSize: 18)),
                    ],
                  ),
                ),
                SizedBox(
                  // categories widget
                  width: double.maxFinite,
                  height: screenHeight * 0.2,
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                      builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is categoriesError) {
                      return Center(child: Text(state.message));
                    } else if (state is CategoriesLoaded) {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final categorie = state.categories[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductByCategorie(categorie.slug,
                                                categorie.name)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Categories(
                                    name: categorie.name,
                                    categoryIcon:
                                        CategoriesIcons().categoryIcons[index]),
                              ),
                            );
                          });
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hot Deals',
                          style: AppFont.widgetTitle(
                              color: AppColor.principle, fontSize: 18)),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllProducts(),
                                ));
                          },
                          child: Row(
                            children: [
                              Text('See all',
                                  style: AppFont.widgetTitle(
                                      color: AppColor.white)),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.white,
                                size: 15,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  //  hot seals widget
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<HotDealsBloc, HotDealsState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HotDealsLoaded) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.hotDeals.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            final product = state.hotDeals[index];
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
                                      context.read<WishlistBloc>().add(
                                          AddToWishlist(
                                              productId:
                                                  product.id.toString()));
                                    },
                                    icon: const Icon(
                                        Icons.favorite_border_outlined)),
                              ),
                            );
                          },
                        );
                      } else if (state is HotDealsError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const Center(
                            child: Text('Something went wrong'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
