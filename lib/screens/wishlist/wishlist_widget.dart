import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';

import 'package:grocery_app/widgets/add_to_wishlist_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
              ctx: context, routeName: ProductDetails.routeName);
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
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: size.width * 0.25,
                  width: size.width * 0.2,
                  child: FancyShimmerImage(
                    imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                    boxFit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          const AddToWishlistButton(),
                        ],
                      ),
                    ),
                    Flexible(
                      child: TextWidget(
                        text: 'Title',
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
                      text: '\u{20B9}200',
                      color: color,
                      textSize: 18.0,
                      maxLines: 1,
                      isTitle: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
