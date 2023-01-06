import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';

class AddToWishlistButton extends StatelessWidget {
  const AddToWishlistButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return IconButton(
      onPressed: () {},
      icon:  Icon(
        IconlyLight.heart,
        size: 22,
        color: color,
      ),
    );
  }
}
