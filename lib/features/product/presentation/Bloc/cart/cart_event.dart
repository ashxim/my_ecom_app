abstract class CartEvent {}

class LoadCartEvent extends CartEvent {
  final String userId;

  LoadCartEvent({required this.userId});
}

class AddToCartEvent extends CartEvent {
  final String userId;
  final int productId;
  final String title;
  final double price;
  final String thumbnail;
  final int quantity;

  AddToCartEvent(
      {required this.userId,
      required this.productId,
      required this.title,
      required this.price,
      required this.thumbnail,
      required this.quantity});
}

class UpdateCartEvent extends CartEvent {
  final String userId;
  final int productId;
  final int quantity;

  UpdateCartEvent(this.userId, this.productId, this.quantity);
}

class RemoveFromCartEvent extends CartEvent {
  final String userId;
  final int productId;

  RemoveFromCartEvent({required this.userId, required this.productId});
}
