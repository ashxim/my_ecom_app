import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/categorie/categories.dart';

class CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSource({required this.client});

  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/products/categories'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
