import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/cart_remote_datasources.dart';
import 'package:my_ecom_app/features/product/domain/entities/cart_entities.dart';

class CartRepository {
  final CartRemoteDatasources dataSource;

  CartRepository({required this.dataSource});

  Future<void> addToCart(String userId, int productId, int quantity,
      String title, double price, String thumbnail) {
    return dataSource.addToCart(
        userId, productId, title, price, thumbnail, quantity);
  }

  Future<void> updateCart(String userId, int productId, int quantity) {
    return dataSource.updateCart(userId, productId, quantity);
  }

  Future<void> removeFromCart(String userId, int productId) {
    return dataSource.removeFromCart(userId, productId);
  }

  Future<List<CartEntities>> getCartItems(String userId) {
    return dataSource.getCartItems(userId);
  }
}
