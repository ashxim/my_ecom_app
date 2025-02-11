import 'package:my_ecom_app/features/product/domain/entities/cart_entities.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRemoteDatasources {
  final SupabaseClient client;
  CartRemoteDatasources(this.client);

  Future<void> addToCart(
    String userId,
    int productId,
    String title,
    double price,
    String thumbnail,
    int quantity,
  ) async {
    final existingProduct = await client
        .from('products')
        .select('id')
        .eq('id', productId)
        .maybeSingle();

    if (existingProduct == null) {
      await client.from('products').insert({
        'id': productId,
        'title': title,
        'price': price,
        'thumbnail': thumbnail,
      });
    }

    await client.from('cart_items').insert({
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
    });
  }

  Future<void> removeFromCart(String userId, String productId) async {
    await client
        .from('cart_items')
        .delete()
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  Future<void> updateCart(String userId, int productId, int quantity) async {
    await client
        .from('cart_items')
        .update({'quantity': quantity})
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  Future<List<CartEntities>> getCartItems(String userId) async {
    print("Fetching cart items for user: $userId");

    final response =
        await client.from('cart_items').select().eq('user_id', userId);

    print("Fetched cart items response: $response"); // <-- Add this line

    return (response as List)
        .map((item) => CartEntities.fromMap(item))
        .toList();
  }
}
