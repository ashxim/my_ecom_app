class CartEntities {
  final int id;
  final String userId;
  final int productId;
  final String? title;
  final double? price;
  final String? thumbnail;
  final int quantity;
  CartEntities({
    required this.userId,
    required this.productId,
    this.title,
    this.price,
    this.thumbnail,
    required this.quantity,
    required this.id,
  });

  factory CartEntities.fromMap(Map<String, dynamic> map) {
    return CartEntities(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      productId: map['product_id'] as int,
      title: map['title'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      thumbnail: map['thumbnail'] as String?,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'quantity': quantity,
    };
  }
}
