import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecom_app/features/product/domain/use_cases/product/Get_Products.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/product/product_state.dart';

import '../../../domain/use_cases/product/GetProductDetails.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetProductDetails getProductDetails;

  ProductBloc({
    required this.getProducts,
    required this.getProductDetails,
  }) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
// on<FetchProductsByCategory>( _onFetchProductsByCategory);
    on<FetchProductDetails>(_onFetchProductDetails);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProducts();
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void _onFetchProductDetails(
      FetchProductDetails event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productDetails = await getProductDetails(event.productId);
      emit(ProductDetailsLoaded(productDetails: productDetails));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
