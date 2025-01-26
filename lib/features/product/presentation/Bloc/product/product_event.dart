import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class FetchProductDetails extends ProductEvent {
  final int productId;

  const FetchProductDetails(this.productId);
}
