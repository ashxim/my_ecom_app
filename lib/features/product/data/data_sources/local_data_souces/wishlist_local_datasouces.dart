import 'package:shared_preferences/shared_preferences.dart';

class WishlistLocalDatasouces {
  final Future<SharedPreferences> prefsFuture;
  WishlistLocalDatasouces(this.prefsFuture);

  Future<List<String>> getWishlist() async {
    final prefs = await prefsFuture;
    return prefs.getStringList('wishlist') ?? [];
  }

  Future<void> addToWishlist(int productId) async {
    final prefs = await prefsFuture;
    final List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    if (wishlist.contains(productId)) {
      wishlist.add(productId as String);
      await prefs.setStringList('wishlist', wishlist);
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    final prefs = await prefsFuture;
    final List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    wishlist.remove(productId);
    await prefs.setStringList('wishlist', wishlist);
  }
}
