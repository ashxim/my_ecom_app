import 'package:equatable/equatable.dart';

import '../../../data/models/product_details/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

class ProductDetailsLoaded extends ProductState {
  final ProductModel productDetails;

  const ProductDetailsLoaded({required this.productDetails});

  @override
  List<Object> get props => [productDetails];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
