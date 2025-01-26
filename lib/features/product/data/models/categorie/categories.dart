import 'package:my_ecom_app/features/product/domain/entities/categories.dart';

class CategoryModel {
  final String slug;
  final String name;
  final String url;

  CategoryModel({required this.slug, required this.name, required this.url});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'slug': slug, 'name': name, 'url': url};
  }

  Category toEntity() {
    return Category(slug: slug, name: name, url: url);
  }
}
