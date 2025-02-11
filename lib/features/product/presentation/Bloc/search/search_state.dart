import 'package:equatable/equatable.dart';
import 'package:my_ecom_app/features/product/domain/entities/product_details_entities.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;
  const SearchLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});
  @override
  List<Object> get props => [message];
}
