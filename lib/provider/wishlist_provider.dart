import 'package:flutter/material.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItem = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItem;
  }





  void addRemoveProductToWishlist({required String productId}) {
    if (_wishlistItem.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _wishlistItem.putIfAbsent(
          productId,
          () => WishlistModel(
              id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _wishlistItem.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItem.clear();
    notifyListeners();
  }
}
