import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';
import 'package:my_ecom_app/features/product/domain/entities/product_details_entities.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchRemoteDatasouces {
  Future<List<Product>> searchProducts(String query) async {
    final response = await http
        .get(Uri.parse("https://dummyjson.com/products/search?q=$query"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return (jsonData['products'] as List)
          .map((productJson) =>
              ProductModel.fromJson(productJson as Map<String, dynamic>))
          .toList(); // Automatically casts to List<Product>
    } else {
      throw Exception('Failed to load products');
    }
  }
}
