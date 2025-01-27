import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_ecom_app/features/product/data/models/product_details/product_model.dart';

class ProductbycategorieRemoteDatasources {
  final http.Client client;
  ProductbycategorieRemoteDatasources({required this.client});

  Future<List<ProductModel>> getproductbycateorie(String name) async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/products/category/$name'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> jsonList = jsonResponse['products'] ?? [];

      // Filter out invalid items
      final validProducts = jsonList.where((json) {
        return json['id'] != null &&
            json['title'] != null &&
            json['price'] != null;
      }).toList();

      return validProducts.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception(' Error: ${response.reasonPhrase}');
    }
  }
}
