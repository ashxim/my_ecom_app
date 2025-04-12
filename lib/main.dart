import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/core/themes/app-color.dart';
import 'package:my_ecom_app/core/themes/app_font.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/categories/categories_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/search/search_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/search/search_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/wishlist/wishlist_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_event.dart';
import 'package:my_ecom_app/core/di/di_product.dart';
import 'package:my_ecom_app/features/product/presentation/screens/authentication/auth_gate.dart';
import 'package:my_ecom_app/features/product/presentation/screens/onBoarding/onboarding_screen_one.dart';
import 'package:my_ecom_app/features/product/presentation/widgets/btm_nav_bar.dart';
import 'core/main_page/onboarding_preferences.dart';
import 'features/product/presentation/Bloc/hot_deals/hot_deals_event.dart';
import 'features/product/presentation/Bloc/productbycategorie/productbycategorie_event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await Supabase.initialize(
    url: 'https://jcwhuundhnqwspgqlvcm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impjd2h1dW5kaG5xd3NwZ3FsdmNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgwNzE3NjYsImV4cCI6MjA1MzY0Nzc2Nn0.FqQPwjPtGa44ScarYO_m1VDyjGP_-S_GJpUc9AjbnA4',
  );
  bool isOnboardingCompleted =
      await OnboardingPreferences.getOnboardingStatus();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.principle,
      scaffoldBackgroundColor: Colors.white,

      // more customization...
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColor.principle,
      scaffoldBackgroundColor: const Color(0xFF121212),

      // more customization...
    );

    return MultiBlocProvider(
        providers: [
          BlocProvider<HotDealsBloc>(
            create: (context) => getIt<HotDealsBloc>()..add(FetchHotDeals()),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => getIt<ProductBloc>()..add(FetchProducts()),
          ),
          BlocProvider<CategoriesBloc>(
            create: (context) =>
                getIt<CategoriesBloc>()..add(FetchCategories()),
          ),
          BlocProvider<ProductByCategoryBloc>(
            create: (context) => getIt<ProductByCategoryBloc>()
              ..add(FetchProductsByCategory('')),
          ),
          BlocProvider<WishlistBloc>(
            create: (context) => getIt<WishlistBloc>()..add(FetchWishlist()),
          ),
          BlocProvider<SearchBloc>(
            create: (context) => getIt<SearchBloc>()
              ..add(
                const SearchProducts(query: 'query'),
              ),
          ),
          BlocProvider<CartBloc>(
            create: (context) => getIt<CartBloc>(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: OnboardingScreenOne()));
  }
}
