// hot_deals_state.dart
import 'package:equatable/equatable.dart';
import '../../../data/models/product_details/product_model.dart';

abstract class HotDealsState extends Equatable {
  @override
  List<Object> get props => [];
}

class HotDealsLoading extends HotDealsState {}

class HotDealsLoaded extends HotDealsState {
  final List<ProductModel> hotDeals;

  HotDealsLoaded({required this.hotDeals});

  @override
  List<Object> get props => [hotDeals];
}

class HotDealsError extends HotDealsState {
  final String message;

  HotDealsError({required this.message});

  @override
  List<Object> get props => [message];
}
