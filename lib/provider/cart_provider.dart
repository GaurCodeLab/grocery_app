import 'package:flutter/material.dart';
import 'package:grocery_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItem = {};

  Map<String, CartModel> get getCartItems {
    return _cartItem;
  }

  void addProductsToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItem.putIfAbsent(
        productId,
        () => CartModel(
              id: DateTime.now().toString(),
              productId: productId,
              quantity: quantity,
            ));

    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItem.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );
    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItem.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }
  void removeOneItem(String productId) {
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItem.clear();
    notifyListeners();
  }
}
