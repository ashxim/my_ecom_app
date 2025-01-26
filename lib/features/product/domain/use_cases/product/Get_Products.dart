import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';
import 'package:my_ecom_app/features/product/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts({required this.repository});

  Future<List<ProductModel>> call() async {
    return await repository.getProducts();
  }
}
