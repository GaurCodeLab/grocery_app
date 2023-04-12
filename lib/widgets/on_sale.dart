import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../inner_screens/product_details_screen.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color Titlecolor = Utils(context).titleColor;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist = wishlistProvider.getWishlistItems.containsKey(productModel.id);

    Size size = Utils(context).getScreenSize;
    return Material(
      color: Theme.of(context).cardColor.withOpacity(0.9),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: themeState.getDarkTheme ? Colors.grey[900] : Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color:
                  themeState.getDarkTheme ? Colors.black : Colors.grey.shade500,
              offset: const Offset(2, 2),
              blurRadius: 10,
              spreadRadius: 0.5,
            ),
            BoxShadow(
              color:
                  themeState.getDarkTheme ? Colors.grey.shade800 : Colors.white,
              offset: const Offset(-2, -2),
              blurRadius: 10,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);

            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FancyShimmerImage(
                            imageUrl: productModel.imageUrl,
                            height: size.height * 0.12,
                            width: size.width * 0.25,
                            boxFit: BoxFit.fill,
                          ),
                          // Image.network(
                          //   'https://i.ibb.co/F0s3FHQ/Apricots.png',
                          //   height: size.height * 0.12,
                          //   fit: BoxFit.fill,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 70.0,
                              ),
                              AddToWishlistButton(
                                productId: productModel.id, isInWishlist: isInWishlist,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: _isInCart
                                    ? null
                                    : () {
                                        cartProvider.addProductsToCart(
                                            productId: productModel.id,
                                            quantity: 1);
                                        //print("item: ${productModel.id}  ");
                                      },
                                child: _isInCart
                                    ? const Icon(
                                        IconlyBold.bag2,
                                        size: 22,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        IconlyLight.bag2,
                                        size: 22,
                                        color: color,
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextWidget(
                          text: productModel.title,
                          color: Titlecolor,
                          textSize: 18,
                          isTitle: true,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          PriceWidget(
                            price: productModel.price,
                            salePrice: productModel.salePrice,
                            isOnSale: true,
                          ),
                          TextWidget(
                            text: productModel.isPiece ? '/piece' : '/kg',
                            color: Colors.green,
                            textSize: 16,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 15,),
                    // Flexible(
                    //     child: AddToCartButton(productId: productModel.id, quantityProduct: 1),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Text(
//   '\u{20B9}280',
//   style: TextStyle(
//     color: SubtitleColor,
//     fontSize: 18,
//   ),
// ),
// RichText(
//   text: TextSpan(
//     text: '1kg/',
//     style: TextStyle(color: SubtitleColor, fontSize: 18),
//     children: <InlineSpan>[
//       TextSpan(
//         text: '\u{20B9}300',
//         style: TextStyle(
//             color: SubtitleColor,
//             fontSize: 18,
//             decoration: TextDecoration.lineThrough),
//       ),
//     ],
//   ),
// ),
