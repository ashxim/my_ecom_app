import 'package:equatable/equatable.dart';
import 'package:my_ecom_app/features/product/data/models/categorie/categories.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class categoriesError extends CategoriesState {
  final String message;
  categoriesError({required this.message});
  @override
  List<Object> get props => [message];
}
