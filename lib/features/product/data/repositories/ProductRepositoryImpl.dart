import 'package:my_ecom_app/features/product/domain/use_cases/product/Get_Products.dart';

import '../../domain/entities/product_details_entities.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_data_souces/wishlist_local_datasouces.dart';
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

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await remoteDataSource.getProductById(id.toString());
    return ProductModel.fromJson(response.toJson());
  }
}
