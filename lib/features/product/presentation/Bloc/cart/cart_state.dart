import 'package:my_ecom_app/features/product/domain/entities/cart_entities.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartEntities> cartItems;

  CartLoaded(this.cartItems);
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}
