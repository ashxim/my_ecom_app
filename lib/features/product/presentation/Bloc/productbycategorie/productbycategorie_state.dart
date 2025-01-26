import 'package:equatable/equatable.dart';

import '../../../domain/entities/product_details_entities.dart';

abstract class ProductByCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<Product> products;

  ProductByCategoryLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductByCategoryError extends ProductByCategoryState {
  final String message;

  ProductByCategoryError(this.message);

  @override
  List<Object> get props => [message];
}
