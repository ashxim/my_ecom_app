import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_event.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/btm_nav_bar.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_event.dart';
import 'package:my_ecom_app/core/di/di_product.dart';
import 'features/product/presentation/Bloc/hot_deals/hot_deals_event.dart';
import 'features/product/presentation/Bloc/productbycategorie/productbycategorie_event.dart';

void main() {
  setup();
  // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HotDealsBloc>(
          create: (context) => getIt<HotDealsBloc>()..add(FetchHotDeals()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => getIt<ProductBloc>()..add(FetchProducts()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => getIt<CategoriesBloc>()..add(FetchCategories()),
        ),
        BlocProvider<ProductByCategoryBloc>(
          create: (context) =>
              getIt<ProductByCategoryBloc>()..add(FetchProductsByCategory('')),
        ),
        BlocProvider<WishlistBloc>(
          create: (context) => getIt<WishlistBloc>()..add(FetchWishlist()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BtmNavBar(),
      ),
    );
  }
}
