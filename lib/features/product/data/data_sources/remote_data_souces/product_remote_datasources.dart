import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';

import '../../../domain/entities/product_details_entities.dart';

class ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSource({required this.client});

  Future<List<ProductModel>> getProducts() async {
    final response =
        await client.get(Uri.parse('https://dummyjson.com/products?limit=0'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> jsonList = jsonMap['products'];
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> getHotDeals() async {
    try {
      final response = await client.get(
        Uri.parse('https://dummyjson.com/products?sortBy=title&order=asc'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> jsonList = jsonMap['products'];
        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load hot deals');
    }
  }

  Future<ProductModel> getProductDetails(int productId) async {
    final response = await client
        .get(Uri.parse('https://dummyjson.com/products/$productId'));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Future<ProductModel> getProductById(String id) async {
    final response =
        await client.get(Uri.parse("https://dummyjson.com/products/$id"));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch product');
    }
  }
}
