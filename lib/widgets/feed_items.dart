import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_cart_dynamic_button.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details_screen.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  @override
  Widget build(BuildContext context) {
    final Color titlecolor = Utils(context).titleColor;
    final Color subtitleColor = Utils(context).subtitleColor;
    final themeState = Provider.of<DarkThemeProvider>(context);
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
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetails.routeName);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FancyShimmerImage(
                            imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                            height: size.height * 0.15,
                            width: size.width * 0.3,
                            boxFit: BoxFit.fill,
                          ),

                          // const SizedBox(
                          //   width: 35.0,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 10, bottom: 80),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.heart,
                                size: 24,
                                color: color,
                              ),
                              // padding: EdgeInsets.only(left:20.0, right: 10),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextWidget(
                          text: 'Apricot',
                          color: titlecolor,
                          textSize: 18,
                          isTitle: true,
                        ),
                      ),
                      TextWidget(
                        text: '\u{20B9}150/500gm',
                        color: subtitleColor,
                        textSize: 16,
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
