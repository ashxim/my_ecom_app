import 'package:my_ecom_app/features/product/data/models/product_details/reviews.dart';

class Product {
  final int id;
  final String title;
  final String thumbnail;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<Review> reviews;
  final List<String> images;

  Product({
    required this.images,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.reviews,
    required this.thumbnail,
  });
}
