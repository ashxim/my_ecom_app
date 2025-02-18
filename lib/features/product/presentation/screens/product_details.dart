import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_event.dart';
import 'package:my_ecom_app/features/product/presentation/screens/cart%20&%20payment/cart.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../Bloc/cart/cart_state.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String thumbnail;
  final String description;
  final double rating;
  final double price;
  final double? discountPercentage;
  final int id;
  List<String> images;

  ProductDetails({
    super.key,
    required this.images,
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
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  @override
  Widget build(BuildContext context) {
    final SupabaseClient client = Supabase.instance.client;
    final String? userId = client.auth.currentUser?.id;
    String myprice = widget.price.toString();
    String mydiscount = widget.price.toString();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double rating = widget.rating;
    late PageController _pageController = PageController();

    double _currentPage = 0;

    @override
    void initState() {
      super.initState();
      _pageController = PageController();
      // Add a listener to update _currentPage continuously.
      _pageController.addListener(() {
        setState(() {
          _currentPage = _pageController.page ?? 0.0;
        });
      });
    }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

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
                icon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      // Access the cart quantity from the CartUpdated state
                      return Stack(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.black,
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
                  },
                ),
              )
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
                    child: SizedBox(
                      height: screenHeight * 0.45,
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: widget.images[index],
                            placeholder: (context, url) => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(60.0),
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballRotateChase,
                                  colors: const [AppColor.principle],
                                  strokeWidth: 0.2,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                DotsIndicator(
                  animate: true,
                  dotsCount: widget.images.length,
                  position: _currentPage,
                  decorator: DotsDecorator(
                    activeColor: AppColor.Black,
                    color: AppColor.Grey,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
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
                            flex: 3,
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
                                SizedBox(
                                    width: 180,
                                    height: 50,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                        maximumSize: WidgetStatePropertyAll(
                                          const Size(200, 50),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (userId != null) {
                                          // Retrieve the current cart state from the CartBloc.
                                          final cartState =
                                              context.read<CartBloc>().state;
                                          bool itemExists = false;

                                          // Assuming your CartBloc state has a 'CartLoaded' state with an 'items' list.
                                          if (cartState is CartLoaded) {
                                            itemExists = cartState.cartItems
                                                .any((item) =>
                                                    item.productId ==
                                                    widget.id);
                                          }

                                          if (!itemExists) {
                                            // If the item isn't already in the cart, add it.
                                            context
                                                .read<CartBloc>()
                                                .add(AddToCartEvent(
                                                  userId: userId,
                                                  productId: widget.id,
                                                  title: widget.title,
                                                  price: widget.price,
                                                  thumbnail: widget.thumbnail,
                                                  quantity: 1,
                                                ));
                                          } else {
                                            // Optionally update the quantity or show a notification.
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Item is already in the cart.'),
                                              ),
                                            );
                                          }
                                        } else {
                                          // User is not authenticated.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Please log in to add to cart.'),
                                            ),
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
                                            color: AppColor.Black,
                                            fontSize: 18),
                                      ),
                                    ))
                              ],
                            ))
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
