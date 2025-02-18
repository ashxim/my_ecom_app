import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_state.dart';
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
import 'package:my_ecom_app/features/product/presentation/screens/cart%20&%20payment/cart.dart';
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/categories.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/hot_deals.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/home%20widget/offers.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/dummy_data/categories.dart';
import 'product_by_categorie.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<void> _refreshData(BuildContext context) async {
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
            IconButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ));
            }, icon:
                BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state is CartLoaded) {
                // Access the cart quantity from the CartUpdated state
                return Stack(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColor.Black,
                      size: 25,
                    ),
                    if (state.cartItems.isNotEmpty)
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                              height: 25,
                              width: 12,
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                  '${state.cartItems.length}', // Display cart item count
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  )))),
                  ],
                );
              } else {
                // Default behavior if not in CartUpdated state
                return const IconButton(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: null, // Disable icon if there's no cart data
                );
              }
            }))
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
                    itemBuilder: (context, index) => const Ads(),
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
                      return const Center(
                          child: LoadingIndicator(
                              indicatorType: Indicator.ballClipRotateMultiple,
                              colors: [AppColor.principle],
                              strokeWidth: 2,
                              backgroundColor: Colors.transparent));
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
                  //  hot deals widget
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<HotDealsBloc, HotDealsState>(
                      builder: (context, state) {
                    if (state is HotDealsLoading) {
                      return const Center(
                          child: LoadingIndicator(
                              indicatorType: Indicator.ballClipRotateMultiple,

                              /// Required, The loading type of the widget
                              colors: const [AppColor.principle],

                              /// Optional, The color collections
                              strokeWidth: 1,

                              /// Optional, The stroke of the line, only applicable to widget which contains line

                              /// Optional, Background of the widget
                              pathBackgroundColor: Colors.black

                              /// Optional, the stroke backgroundColor
                              ));
                    } else if (state is HotDealsError) {
                      return Center(child: Text(state.message));
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
                                    images: product.images,
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
                                        AddToWishlist(productId: product.id));
                                  },
                                  icon: const Icon(
                                      Icons.favorite_border_outlined)),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
