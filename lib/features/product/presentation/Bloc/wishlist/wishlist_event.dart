import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class FetchWishlist extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final int productId;
  final List<String> images;
  const AddToWishlist({required this.images, required this.productId});

  @override
  List<Object> get props => [productId];
}

class RemoveWishlist extends WishlistEvent {
  final int productId;

  const RemoveWishlist({required this.productId});

  @override
  List<Object> get props => [productId];
}
