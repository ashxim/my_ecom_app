import 'package:equatable/equatable.dart';
import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';

abstract class WishlistState extends Equatable {
  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<ProductModel> products;
  WishlistLoaded({required this.products});
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError({required this.message});
}
