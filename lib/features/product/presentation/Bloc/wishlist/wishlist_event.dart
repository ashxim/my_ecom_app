import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWishlist extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final String productId;

  const AddToWishlist({required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveWishlist extends WishlistEvent {
  final String productId;

  const RemoveWishlist({required this.productId});

  @override
  List<Object> get props => [productId];
}
