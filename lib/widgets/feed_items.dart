import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_cart_dynamic_button.dart';
import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details_screen.dart';

class FeedWidget extends StatefulWidget {
   FeedWidget({ Key? key}) : super(key: key);


  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
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
    final Color titlecolor = Utils(context).titleColor;
    final Color subtitleColor = Utils(context).subtitleColor;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
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
        child: InkWell(
          onTap: () {
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
            Navigator.pushNamed(context, ProductDetails.routeName, arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(30),
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
                            FancyShimmerImage(
                              imageUrl: productModel.imageUrl,
                              height: size.height * 0.15,
                              width: size.width * 0.3,
                              boxFit: BoxFit.fill,
                            ),

                            // const SizedBox(
                            //   width: 35.0,
                            // ),
                            const Flexible(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.0, right: 10, bottom: 80),
                                 child : AddToWishlistButton(),

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
                      PriceWidget(
                        salePrice: productModel.salePrice,
                        price: productModel.price,
                        isOnSale: true,


                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     PriceWidget(
                      //       price: 300,
                      //       salePrice: 280,
                      //       isOnSale: false,
                      //       textPrice: 1,
                      //     ),
                      //     // const SizedBox(width: 20,),
                      //
                      //     // GestureDetector(
                      //     //   onTap: () {},
                      //     //   child: Icon(
                      //     //     IconlyLight.plus,
                      //     //     size: 22,
                      //     //     color: color,
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(left: 40.0, top: 10, bottom: 5),
                        child: AddToCartButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
