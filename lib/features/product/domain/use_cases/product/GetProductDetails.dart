import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';
import 'package:my_ecom_app/features/product/domain/repositories/product_repository.dart';

class GetProductDetails {
  final ProductRepository repository;

  GetProductDetails({required this.repository});

  Future<ProductModel> call(int id) async {
    return await repository.getProductDetails(id);
  }
}
