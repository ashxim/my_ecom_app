import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/data_sources/local_data_souces/wishlist_local_datasouces.dart';
import '../../../domain/repositories/product_repository.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistLocalDatasouces wishlistLocalData;
  final ProductRepository productRepository;

  WishlistBloc(
      {required this.productRepository, required this.wishlistLocalData})
      : super(WishlistLoading()) {
    on<FetchWishlist>((event, emit) async {
      try {
        final productIds = await wishlistLocalData.getWishlist();
        final products = await Future.wait(
            productIds.map((id) => productRepository.getProductById(id)));

        emit(WishlistLoaded(products: products));
      } catch (e) {
        emit(WishlistError(message: e.toString()));
      }
    });

    on<AddToWishlist>((event, emit) async {
      try {
        await wishlistLocalData.addToWishlist(event.productId);
        final productIds = await wishlistLocalData.getWishlist();
        final products = await Future.wait(
            productIds.map((id) => productRepository.getProductById(id)));
        emit(WishlistLoaded(products: products));
      } catch (e) {
        emit(WishlistError(message: 'Failed to add to wishlist: $e'));
      }
    });

    on<RemoveWishlist>((event, emit) async {
      try {
        // Remove the product ID from local storage
        await wishlistLocalData.removeFromWishlist(event.productId);
        print('Removed product ID: ${event.productId}');
        // Fetch the updated list of product IDs
        final productIds = await wishlistLocalData.getWishlist();
        print('Updated wishlist IDs: $productIds');
        // Fetch the updated list of products
        final products = await Future.wait(
          productIds.map((id) => productRepository.getProductById(id)),
        );
        print('Updated products: $products');
        // Emit the new state with updated products
        emit(WishlistLoaded(products: products));
      } catch (e) {
        // Handle errors and emit an error state
        emit(WishlistError(message: 'Failed to remove item: $e'));
      }
    });
  }
}
