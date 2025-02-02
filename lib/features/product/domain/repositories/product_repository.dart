import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts(); // For All Products
  Future<List<ProductModel>> getHotDeals(); // For Hot Deals
  Future<ProductModel> getProductDetails(int id); // For Product Details
  Future<ProductModel> getProductById(String id);
}
