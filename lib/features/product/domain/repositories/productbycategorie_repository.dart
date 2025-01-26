import 'package:my_ecom_app/features/product/domain/entities/product_details_entities.dart';

abstract class ProductByCategoryRepository {
  Future<List<Product>> getProductsByCategory(String categorySlug);
}
