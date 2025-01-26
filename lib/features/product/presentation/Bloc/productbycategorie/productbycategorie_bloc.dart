import 'package:bloc/bloc.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_event.dart';
import 'package:my_ecom_app/features/product/presentation/Bloc/productbycategorie/productbycategorie_state.dart';

import '../../../domain/use_cases/categories/productbycategorie_usecase.dart';

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final GetProductsByCategory getProductsByCategory;

  ProductByCategoryBloc({required this.getProductsByCategory})
      : super(ProductByCategoryInitial()) {
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
  }

  Future<void> _onFetchProductsByCategory(FetchProductsByCategory event,
      Emitter<ProductByCategoryState> emit) async {
    emit(ProductByCategoryLoading());
    try {
      final products = await getProductsByCategory(event.categorySlug);

      // Filter out invalid products
      final validProducts = products.where((product) {
        return product.id != 0 &&
            product.title.isNotEmpty &&
            product.price != 0.0;
      }).toList();

      emit(ProductByCategoryLoaded(validProducts));
    } catch (e) {
      emit(ProductByCategoryError(e.toString()));
    }
  }
}
