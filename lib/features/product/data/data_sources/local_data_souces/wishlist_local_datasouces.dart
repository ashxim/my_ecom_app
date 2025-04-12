import 'package:shared_preferences/shared_preferences.dart';

class WishlistLocalDatasouces {
  final Future<SharedPreferences> prefsFuture;

  WishlistLocalDatasouces(
    this.prefsFuture,
  );

  Future<List<String>> getWishlist() async {
    final prefs = await prefsFuture;
    final List<String>? wishlist = prefs.getStringList('wishlist');
    if (wishlist == null) {
      return [];
    }
    return wishlist;
  }

  Future<void> addToWishlist(int productId) async {
    final prefs = await prefsFuture;

    List<String> wishlist =
        prefs.getStringList('wishlist') ?? []; // Ensure it's a list
    print("Current wishlist: $wishlist");

    final productIdString = productId.toString();

    if (!wishlist.contains(productIdString)) {
      wishlist.add(productIdString);
      await prefs.setStringList('wishlist', wishlist);
      print("Updated wishlist: $wishlist");
    } else {
      print("Product already in wishlist");
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    final prefs = await prefsFuture;
    final List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    final productIdString = productId.toString();

    if (wishlist.contains(productIdString)) {
      wishlist.remove(productIdString);
      await prefs.setStringList('wishlist', wishlist);
      print("Updated wishlist: $wishlist");
    } else {
      print("Product already in wishlist");
    }
  }
}
