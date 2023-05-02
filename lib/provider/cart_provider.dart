import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebae_consts.dart';
import 'package:grocery_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  static Map<String, CartModel> _cartItem = {};

  Map<String, CartModel> get getCartItems {
    return _cartItem;
  }

  // void addProductsToCart({
  //   required String productId,
  //   required int quantity,
  // }) {
  //   _cartItem.putIfAbsent(
  //       productId,
  //       () => CartModel(
  //             id: DateTime.now().toString(),
  //             productId: productId,
  //             quantity: quantity,
  //           ));
  //
  //   notifyListeners();
  // }

  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;
    String _uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    }
    final length = userDoc.get('userCart').length;
    for (int i = 0; i < length; i++) {
      _cartItem.putIfAbsent(
          userDoc.get('userCart')[i]['productId'],
          () => CartModel(
              id: userDoc.get('userCart')[i]['cartId'],
              productId: userDoc.get('userCart')[i]['productId'],
              quantity: userDoc.get('userCart')[i]['quantity']));
    }
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
