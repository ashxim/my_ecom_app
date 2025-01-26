import '../../domain/entities/product_details_entities.dart';
import '../../domain/repositories/productbycategorie_repository.dart';
import '../data_sources/remote_data_souces/productbycategorie_remote_datasources.dart';

class ProductByCategoryRepositoryImpl implements ProductByCategoryRepository {
  final ProductbycategorieRemoteDatasources remoteDataSource;

  ProductByCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProductsByCategory(String categoryname) async {
    try {
      // Fetch ProductModel from the remote source
      final productModels =
          await remoteDataSource.getproductbycateorie(categoryname);

      // Convert ProductModel to Product (Entity)
      return productModels
          .map((model) => Product(
                id: model.id,
                title: model.title,
                description: model.description,
                discountPercentage: model.discountPercentage ?? 0.0,
                rating: model.rating,
                price: model.price,
                thumbnail: model.thumbnail,
                reviews: model.reviews ?? [],
              ))
          .toList();
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }
}
