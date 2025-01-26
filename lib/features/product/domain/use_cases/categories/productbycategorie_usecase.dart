import '../../entities/product_details_entities.dart';
import '../../repositories/productbycategorie_repository.dart';

class GetProductsByCategory {
  final ProductByCategoryRepository repository;

  GetProductsByCategory({required this.repository});

  Future<List<Product>> call(String categorySlug) {
    return repository.getProductsByCategory(categorySlug);
  }
}
