import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote_data_souces/product_remote_datasources.dart';
import '../models/product_details/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    return await remoteDataSource.getProducts();
  }

  @override
  Future<List<ProductModel>> getHotDeals() async {
    return await remoteDataSource.getHotDeals();
  }

  @override
  Future<ProductModel> getProductDetails(int productId) async {
    return await remoteDataSource.getProductDetails(productId);
  }
}
