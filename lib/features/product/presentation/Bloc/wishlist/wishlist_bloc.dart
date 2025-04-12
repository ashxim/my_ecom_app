import 'package:bloc/bloc.dart';

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
        final products = await Future.wait(productIds.map((productId) =>
            productRepository.getProductById(int.parse(productId))));

        emit(WishlistLoaded(products: products));
      } catch (e) {
        emit(WishlistError(message: e.toString()));
      }
    });

    on<AddToWishlist>((event, emit) async {
      try {
        emit(WishlistLoading()); // ✅ Trigger a loading state before updating UI
        await wishlistLocalData.addToWishlist(event.productId);
        final productIds = await wishlistLocalData.getWishlist();
        final products = await Future.wait(productIds
            .map((id) => productRepository.getProductById(int.parse(id))));
        emit(WishlistLoaded(products: products));
      } catch (e) {
        emit(WishlistError(message: 'Failed to add to wishlist: $e'));
      }
    });
    on<RemoveWishlist>((event, emit) async {
      try {
        emit(WishlistLoading());
        await wishlistLocalData.removeFromWishlist(event.productId);

        // ✅ Fetch updated wishlist after removing an item
        final updatedProductIds = await wishlistLocalData.getWishlist();
        final updatedProducts = await Future.wait(
          updatedProductIds
              .map((id) => productRepository.getProductById(int.parse(id))),
        );

        emit(WishlistLoaded(
            products: updatedProducts)); // ✅ Emit new state to refresh UI
      } catch (e) {
        emit(WishlistError(message: e.toString()));
      }
    });
  }
}
