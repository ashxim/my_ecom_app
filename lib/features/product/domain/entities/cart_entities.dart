class CartEntities {
  final int id;
  final String userId;
  final int productId;
  final String? title;
  final double? price;
  final String? thumbnail;
  final int quantity;
  final double discountPercentage;
  CartEntities(
      {required this.userId,
      required this.productId,
      this.title,
      this.price,
      this.thumbnail,
      required this.quantity,
      required this.id,
      required this.discountPercentage});

  factory CartEntities.fromMap(Map<String, dynamic> map) {
    final productData = map['products'] as Map<String, dynamic>?;

    return CartEntities(
        id: map['id'] as int,
        userId: map['user_id'] as String,
        productId: map['product_id'] as int,
        title: productData?['title'] ?? map['title'] as String,
        price:
            (productData?['price'] ?? map['price'] as num?)?.toDouble() ?? 0.0,
        thumbnail: productData?['thumbnail'] ?? map['thumbnail'] as String,
        quantity: map['quantity'] as int,
        discountPercentage: (productData?['discountPercentage'] ??
                    map['discountPercentage'] as num?)
                ?.toDouble() ??
            0.0);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'discountPercentage': discountPercentage
    };
  }
}
