import 'package:equatable/equatable.dart';

abstract class ProductByCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductsByCategory extends ProductByCategoryEvent {
  final String categorySlug;

  FetchProductsByCategory(
    this.categorySlug,
  );

  @override
  List<Object> get props => [categorySlug];
}
