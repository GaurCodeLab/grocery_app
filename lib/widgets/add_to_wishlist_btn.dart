import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebae_consts.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';

class AddToWishlistButton extends StatelessWidget {
  const AddToWishlistButton(
      {Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // final productModel = Provider.of<ProductModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    // bool? isInWishlist = wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return GestureDetector(
      onTap: () {
        final User? user = authInstance.currentUser;
        if(user ==null){
          GlobalMethods.errorDialog(subtitle: 'No user found, login first', context: context);
          return;
        }
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true ? IconlyBold.heart : IconlyLight.heart,
        size: 28,
        color: isInWishlist != null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
