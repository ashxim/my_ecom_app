import 'package:my_ecom_app/features/product/data/data_sources/remote_data_souces/cart_remote_datasources.dart';
import 'package:my_ecom_app/features/product/domain/entities/cart_entities.dart';
import 'package:my_ecom_app/features/product/domain/repositories/cart_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CartRepository {
  Future<void> addToCart(String userId, int productId, String title,
      double price, String thumbnail, int quantity);
  Future<void> updateCart(String userId, int productId, int quantity);
  Future<void> removeFromCart(String userId, String productId);
  Future<List<CartEntities>> getCartItems(String userId);
}

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasources dataSource;

  CartRepositoryImpl({required this.dataSource});

  @override
  Future<void> addToCart(String userId, int productId, String title,
      double price, String thumbnail, int quantity) {
    return dataSource.addToCart(
        userId, productId, title, price, thumbnail, quantity);
  }

  @override
  Future<void> updateCart(String userId, int productId, int quantity) {
    return dataSource.updateCart(userId, productId, quantity);
  }

  @override
  Future<void> removeFromCart(String userId, String productId) {
    return dataSource.removeFromCart(userId, productId);
  }

  @override
  Future<List<CartEntities>> getCartItems(String userId) async {
    final supabaseClient = Supabase.instance.client;
    final response = await supabaseClient
        .from('cart_items')
        .select('*, products(*)') // Join with products table
        .eq('user_id', userId);

    return (response as List)
        .map((item) => CartEntities.fromMap(item))
        .toList();
  }
}
