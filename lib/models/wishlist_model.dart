import 'package:flutter/material.dart%20';

class WishlistModel with ChangeNotifier {
  final String id, productId;


  WishlistModel(
      {
        required this.id,
        required this.productId,
        }
      );
}
