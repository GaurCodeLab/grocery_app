import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../inner_screens/product_details_screen.dart';
import '../services/global_methods.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color Titlecolor = Utils(context).titleColor;
    final Color SubtitleColor = Utils(context).subtitleColor;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = Utils(context).color;
    bool isfavourite = false;

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
            GlobalMethods.navigateTo(
                ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FancyShimmerImage(
                          imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                          height: size.height * 0.12,
                          width: size.width*0.25,
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
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.heart,
                                size: 22,
                                color: color,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag2,
                                size: 22,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextWidget(
                        text: 'Apricot',
                        color: Titlecolor,
                        textSize: 18,
                        isTitle: true,
                      ),
                    ),
                    const PriceWidget(
                      price: 300,
                      salePrice: 280 ,
                      isOnSale: true,
                      textPrice:  1,
                    ),
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
