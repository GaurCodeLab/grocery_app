import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/models/wishlist_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';

import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    // final productModel = Provider.of<ProductModel>(context);

    final getCurrentProduct =
        productProvider.findProductById(wishlistModel.productId);

    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;

    //  final wishlistItemsLists = wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: wishlistModel.productId);
        },
        child: SizedBox(
          height: size.height * 0.20,
          child: Neumorphic(
            style: NeumorphicStyle(
                color: Theme.of(context).cardColor,
                intensity: 0.50,
                depth: 4,
                shadowLightColor: Colors.grey.shade500,
                shadowDarkColor: Colors.black,
                lightSource: LightSource.topLeft),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: size.width * 0.25,
                    width: size.width * 0.2,
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // cartProvider.addProductsToCart(
                                //     productId: getCurrentProduct.id, quantity: 1);
                              },
                              icon: Icon(
                                IconlyLight.bag2,
                                color: color,
                              ),
                            ),
                            AddToWishlistButton(
                                productId: getCurrentProduct.id,
                                isInWishlist: isInWishlist),
                          ],
                        ),
                      ),
                      Flexible(
                        child: TextWidget(
                          text: getCurrentProduct.title,
                          color: color,
                          textSize: 20.0,
                          maxLines: 2,
                          isTitle: true,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextWidget(
                        text: '\u{20B9}${usedPrice.toStringAsFixed(2)}',
                        color: color,
                        textSize: 18.0,
                        maxLines: 1,
                        isTitle: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
