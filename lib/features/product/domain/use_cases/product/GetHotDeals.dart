import 'package:my_ecom_app/features/product/domain/repositories/product_repository.dart';

import '../../../data/models/product_details/product_model.dart';

class GetHotDeals {
  final ProductRepository repository;

  GetHotDeals({required this.repository});

  Future<List<ProductModel>> call() async {
    return await repository.getHotDeals();
  }
}
