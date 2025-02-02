import 'package:my_ecom_app/features/product/data/models/product_details/reviews.dart';
import 'package:my_ecom_app/features/product/domain/entities/product_details_entities.dart';

class ProductModel extends Product {
  @override
  final int id;
  @override
  final String title;
  @override
  final String thumbnail;
  @override
  final String description;
  final String category;
  @override
  final double price;
  @override
  final double discountPercentage;
  @override
  final double rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  @override
  final List<Review> reviews;

  ProductModel({
    required this.thumbnail,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
  }) : super(
            id: id,
            title: title,
            description: description,
            price: price,
            discountPercentage: discountPercentage,
            rating: rating,
            reviews: reviews,
            thumbnail: thumbnail);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int?,
      tags: json['tags'] is List ? List<String>.from(json['tags']) : null,
      brand: json['brand'] as String?,
      sku: json['sku'] as String?,
      weight: json['weight'] as int?,
      warrantyInformation: json['warrantyInformation'] as String?,
      shippingInformation: json['shippingInformation'] as String?,
      availabilityStatus: json['availabilityStatus'] as String?,
      reviews: (json['reviews'] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail,
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }

  // Add this method to convert ProductModel to Product entity
  Product toEntity() {
    return Product(
        id: id,
        title: title,
        description: description,
        price: price,
        rating: rating,
        discountPercentage: discountPercentage,
        reviews: reviews,
        thumbnail: thumbnail);
  }
}
