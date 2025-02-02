import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/di/di_product.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/search/search_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/search/search_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/search/search_state.dart';
import 'package:my_ecom_app/features/product/presentation/screens/product_details.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/search_items.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SearchBloc>()..add(const SearchProducts(query: 'query')),
      child: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [AppColor.Grey, Color(0xff007aff), AppColor.white],
              ),
            ),
          ),

          // Main UI
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Text(
                  "Search",
                  style: AppFont.appTitle(color: AppColor.principle),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Search Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          onChanged: (query) {
                            if (query.isNotEmpty) {
                              context
                                  .read<SearchBloc>()
                                  .add(SearchProducts(query: query));
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Search on your product ...',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                            ),
                            border: InputBorder.none,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // BlocBuilder to display results
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        print('Emitted state: $state');
                        if (state is SearchLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is SearchLoaded) {
                          return ListView.builder(
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
                                        discountPercentage:
                                            product.discountPercentage,
                                      ),
                                    ),
                                  );
                                },
                                child: SearchItems(
                                  id: product.id,
                                  title: product.title,
                                  price: product.price,
                                  thumbnail: product.thumbnail,
                                ),
                              );
                            },
                          );
                        } else if (state is SearchError) {
                          return Center(child: Text('Error: ${state.message}'));
                        }
                        return const Center(
                            child: Text("Start searching for products!"));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
