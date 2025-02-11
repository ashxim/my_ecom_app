import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_ecom_app/features/product/data/data_sources/local_data_souces/wishlist_local_datasouces.dart';
import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/cart_remote_datasources.dart';
import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/productbycategorie_remote_datasources.dart';
import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/search_remote_datasouces.dart';
import 'package:my_ecom_app/features/product/data/repositories/CartRepositoryImpl.dart';
import 'package:my_ecom_app/features/product/data/repositories/productbycategorie_impl.dart';
import 'package:my_ecom_app/features/product/domain/repositories/productbycategorie_repository.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/categories/productbycategorie_usecase.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/product/GetHotDeals.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/product/GetProductDetails.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/cart/cart_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/hot_deals/hot_deals_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/search/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/product/data/data_sources/remote_data_souces/product_remote_datasources.dart';
import '../../features/product/data/repositories/ProductRepositoryImpl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/use_cases/cart_usecases.dart';
import '../../features/product/domain/use_cases/product/Get_Products.dart';
import '../../features/product/presentation/Bloc/product/product_bloc.dart';
import 'package:my_ecom_app/features/product/data/repositories/GetCategories_implements.dart';
import '../../features/product/data/data_sources/remote_data_souces/categorie_remote_datasources.dart';
import '../../features/product/domain/repositories/categories_repository.dart';
import '../../features/product/domain/use_cases/categories/categorie_usecases.dart';
import '../../features/product/presentation/Bloc/categories/categories_bloc.dart';
import '../../features/product/presentation/Bloc/wishlist/wishlist_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  // Register data sources
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(client: http.Client()),
  );

  // Register repositories
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
        remoteDataSource: getIt<ProductRemoteDataSource>()),
  );

  // Register use cases
  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(repository: getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetHotDeals>(
    () => GetHotDeals(repository: getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetProductDetails>(
    () => GetProductDetails(repository: getIt<ProductRepository>()),
  );

  // Register BLoC
  getIt.registerFactory<ProductBloc>(() => ProductBloc(
        getProducts: getIt<GetProducts>(),
        getProductDetails: getIt<GetProductDetails>(),
      ));

  getIt.registerFactory<HotDealsBloc>(() => HotDealsBloc(
        getHotDeals: getIt<GetHotDeals>(),
      ));
  // category di
  // remote ds
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(client: http.Client()),
  );

  // Register repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => GetcategoriesImplements(
        categoryRemoteDataSource: getIt<CategoryRemoteDataSource>()),
  );

  // Register use cases
  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(repository: getIt<CategoryRepository>()),
  );

  getIt.registerFactory<CategoriesBloc>(() => CategoriesBloc(
        getCategories: getIt<GetCategories>(),
      ));

  // product by category
  // remote ds
  getIt.registerLazySingleton<ProductbycategorieRemoteDatasources>(
    () => ProductbycategorieRemoteDatasources(client: http.Client()),
  );

  // Register repositories
  getIt.registerLazySingleton<ProductByCategoryRepository>(
    () => ProductByCategoryRepositoryImpl(
        remoteDataSource: getIt<ProductbycategorieRemoteDatasources>()),
  );

  // Register use cases
  getIt.registerLazySingleton<GetProductsByCategory>(
    () =>
        GetProductsByCategory(repository: getIt<ProductByCategoryRepository>()),
  );

  getIt.registerFactory<ProductByCategoryBloc>(() => ProductByCategoryBloc(
        getProductsByCategory: getIt<GetProductsByCategory>(),
      ));
  // wishlist
  getIt.registerLazySingleton<WishlistLocalDatasouces>(
    () => WishlistLocalDatasouces(SharedPreferences.getInstance()),
  );
  // Register ProductRepository

  getIt.registerLazySingleton<WishlistBloc>(() => WishlistBloc(
        wishlistLocalData: getIt<WishlistLocalDatasouces>(),
        productRepository: getIt<ProductRepository>(),
      ));

  // search screen
  getIt.registerLazySingleton<SearchRemoteDatasouces>(
    () => SearchRemoteDatasouces(),
  );

  getIt.registerLazySingleton<SearchBloc>(
      () => SearchBloc(getIt<SearchRemoteDatasouces>()));

  // cart screen
  // Data sources
  getIt.registerLazySingleton<CartRemoteDatasources>(
      () => CartRemoteDatasources(Supabase.instance.client));

  // Repositories
  getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(dataSource: getIt<CartRemoteDatasources>()));

  // Use cases
  getIt.registerLazySingleton<AddToCartUseCase>(
      () => AddToCartUseCaseImpl(getIt<CartRepository>()));
  getIt.registerLazySingleton<UpdateCartUseCase>(
      () => UpdateCartUseCaseImpl(repository: getIt<CartRepository>()));
  getIt.registerLazySingleton<RemoveFromCartUseCase>(
      () => RemoveFromCartUseCaseImpl(repository: getIt<CartRepository>()));
  getIt.registerLazySingleton<GetCartItemsUseCase>(
      () => GetCartItemsUseCaseImpl(repository: getIt<CartRepository>()));

  // BLoC
  getIt.registerLazySingleton(() => CartBloc(
        addToCartUseCase: getIt<AddToCartUseCase>(),
        updateCartUseCase: getIt<UpdateCartUseCase>(),
        removeFromCartUseCase: getIt<RemoveFromCartUseCase>(),
        getCartItemsUseCase: getIt<GetCartItemsUseCase>(),
      ));
}
