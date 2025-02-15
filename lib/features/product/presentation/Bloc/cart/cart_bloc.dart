import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/cart_usecases.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final UpdateCartUseCase updateCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  CartBloc(
      {required this.addToCartUseCase,
      required this.updateCartUseCase,
      required this.getCartItemsUseCase,
      required this.removeFromCartUseCase})
      : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateCartEvent>(_onUpdateCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    try {
      print('Loading cart for user: ${event.userId}');
      final cartItems = await getCartItemsUseCase(event.userId);
      print('Fetching cart items for user: ${event.userId}');
      print('Fetched cart items response: $cartItems');
      emit(CartLoaded(cartItems));
    } catch (error) {
      print('Error loading cart: $error');
      emit(CartError(message: 'Failed to load cart'));
    }
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      // Check if the product exists in the products table

      print('Adding item to cart: ${event.productId} for user ${event.userId}');
      await addToCartUseCase(
        event.userId,
        event.productId,
        event.title,
        event.price,
        event.thumbnail,
        event.quantity,
      );
      print('Item added successfully. Reloading cart...');
      add(LoadCartEvent(userId: event.userId));
    } catch (error) {
      print('Error adding item to cart: $error');
      emit(CartError(message: 'Failed to add item to cart'));
    }
  }

  Future<void> _onUpdateCart(
      UpdateCartEvent event, Emitter<CartState> emit) async {
    await updateCartUseCase(event.userId, event.productId, event.quantity);
    add(LoadCartEvent(userId: event.userId));
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      await removeFromCartUseCase(event.userId, event.productId);
      print('Item removed successfully');
      add(LoadCartEvent(
          userId: event.userId)); // Reload the cart after removing the item
    } catch (error) {
      print('Error removing item from cart: $error');
      emit(CartError(message: 'Failed to remove item from cart'));
    }
  }
}
