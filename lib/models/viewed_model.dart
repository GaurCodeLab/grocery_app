import 'package:flutter/material.dart%20';

class ViewedModel with ChangeNotifier {
  final String id, productId;

  ViewedModel({
    required this.id,
    required this.productId,
  });
}
