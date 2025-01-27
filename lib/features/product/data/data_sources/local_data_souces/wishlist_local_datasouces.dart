import 'package:my_ecom_app/features/product/presentation/screens/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistLocalDatasouces {
  final Future<SharedPreferences> prefsFuture;
  WishlistLocalDatasouces(this.prefsFuture);

  Future<List<String>> getWishlist() async {
    final prefs = await prefsFuture;
    return prefs.getStringList('wishlist') ?? [];
  }

  Future<void> addToWishlist(String productId) async {
    final prefs = await prefsFuture;
    final List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    if (!wishlist.contains(productId)) {
      wishlist.add(productId);
      await prefs.setStringList('wishlist', wishlist);
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    final prefs = await prefsFuture;
    final List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    wishlist.remove(productId);
    await prefs.setStringList('wishlist', wishlist);
  }
}
