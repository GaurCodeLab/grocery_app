import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart ';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/viewed_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_cart_dynamic_button.dart';
import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details_screen.dart';

class FeedWidget extends StatefulWidget {
  FeedWidget({Key? key}) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  String? quantityProduct;

  String itemQuantity = '1';

  @override
  void initState() {
    quantityProduct = '1';

    super.initState();
  }

  // @override
  // void dispose() {
  //   //_quantityTextController.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final Color titlecolor = Utils(context).titleColor;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).cardColor,
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
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // GlobalMethods.navigateTo(
                              //     ctx: context, routeName: ProductDetails.routeName);
                              Navigator.pushNamed(context, ProductDetails.routeName,
                                  arguments: productModel.id);
                              viewedProvider.addProductsToViewedItems(productId: productModel.id);

                            },
                            child: FancyShimmerImage(
                              imageUrl: productModel.imageUrl,
                              height: size.height * 0.15,
                              width: size.width * 0.3,
                              boxFit: BoxFit.fill,
                            ),
                          ),

                          // const SizedBox(
                          //   width: 35.0,
                          // ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 10, bottom: 80),
                              child: AddToWishlistButton(
                                  productId: productModel.id,
                                  isInWishlist: isInWishlist),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextWidget(
                        text: productModel.title,
                        color: titlecolor,
                        textSize: 18,
                        isTitle: true,
                      ),
                    ),
                    Row(
                      children: [
                        PriceWidget(
                          salePrice: productModel.salePrice,
                          price: productModel.price,
                          isOnSale: productModel.isOnSale ? true : false,
                        ),
                        TextWidget(
                          text: productModel.isPiece ? '/piece' : '/kg',
                          color: Colors.green,
                          textSize: 16,
                          isTitle: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, right: 4.0, top: 17.0),
                            child: TextWidget(
                                text: 'Qty:', color: color, textSize: 14),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: categoryDropDown(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 15),
                        child: AddToCartButton(quantity: quantityProduct!)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: itemQuantity,
        onChanged: (value) {
          setState(() {
            itemQuantity = value!;
            quantityProduct = itemQuantity;
          });
          print(itemQuantity);
        },
        hint: const Text('Qty: '),
        items: const [
          DropdownMenuItem(
            value: '1',
            child: Text(
              '1',
            ),
          ),
          DropdownMenuItem(
            value: '2',
            child: Text(
              '2',
            ),
          ),
          DropdownMenuItem(
            value: '3',
            child: Text(
              '3',
            ),
          ),
          DropdownMenuItem(
            value: '4',
            child: Text('4'),
          ),
          DropdownMenuItem(
            value: '5',
            child: Text('5'),
          ),
        ],
      ),
    );
  }
}
