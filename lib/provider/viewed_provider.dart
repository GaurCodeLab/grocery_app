import 'package:flutter/material.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class ViewedProvider with ChangeNotifier {
  final Map<String, ViewedModel> _viewedItem = {};

  Map<String, ViewedModel> get getViewedItems {
    return _viewedItem;
  }

  void addProductsToViewedItems({
    required String productId,
  }) {
    _viewedItem.putIfAbsent(
        productId,
        () => ViewedModel(
              id: DateTime.now().toString(),
              productId: productId,
            ));

    notifyListeners();
  }

  void clearViewedItems() {
    _viewedItem.clear();
    notifyListeners();
  }
}
