import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/models/cart_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';
import 'package:grocery_app/widgets/quantity_controller_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.quantityState}) : super(key: key);
  final int quantityState;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = widget.quantityState.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
   // final themeState = Provider.of<DarkThemeProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrentProduct =
        productProvider.findProductById(cartModel.productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
   // final cartItemsLists =cartProvider.getCartItems.values.toList().reversed.toList();
    //final productModel = Provider.of<ProductModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);

    Size size = Utils(context).getScreenSize;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productId);
      },
      child: Row(
        children: [
          Expanded(
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
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: size.height * 0.18,
                    width: size.width * 0.22,
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: getCurrentProduct.title,
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Row(
                          children: [
                            QuantityController(
                                fct: () {
                                  if (_quantityTextController.text == '1') {
                                    return;
                                  } else {
                                    setState(() {
                                      cartProvider.reduceQuantityByOne(
                                          cartModel.productId);
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) -
                                              1)
                                          .toString();
                                    });
                                  }
                                },
                                icon: CupertinoIcons.minus,
                                color: Colors.red),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: _quantityTextController,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                onChanged: (v) {
                                  setState(() {
                                    if (v.isEmpty) {
                                      _quantityTextController.text = '1';
                                    } else {
                                      return;
                                    }
                                  });
                                },
                              ),
                            ),
                            QuantityController(
                                fct: () {
                                  setState(() {
                                    cartProvider.increaseQuantityByOne(
                                        cartModel.productId);
                                    _quantityTextController.text = (int.parse(
                                                _quantityTextController.text) +
                                            1)
                                        .toString();
                                  });
                                },
                                icon: CupertinoIcons.plus,
                                color: Colors.green),
                          ],
                        ),
                      ),
                      // AddToCartQuantity(quantityTextController: _quantityTextController,),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            cartProvider.removeOneItem(cartModel.productId);
                            //  print('${cartModel.productId}');
                          },
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () {},
                            child: AddToWishlistButton(
                                productId: getCurrentProduct.id,
                                isInWishlist: isInWishlist)),
                        const SizedBox(
                          height: 15,
                        ),
                        TextWidget(
                            text: '\u{20B9}${usedPrice.toStringAsFixed(2)}',
                            color: color,
                            textSize: 18),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
