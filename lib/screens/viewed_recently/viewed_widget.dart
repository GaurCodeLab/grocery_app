import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/viewed_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../consts/firebae_consts.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyWidget> createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final viewedModel = Provider.of<ViewedModel>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct =
        productProvider.findProductById(viewedModel.productId);

    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    bool? isViewedItemInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    return ListTile(
      subtitle: Text('\u{20B9}${usedPrice.toStringAsFixed(2)}'),
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: getCurrentProduct.id);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.25,
        height: size.width * 0.27,
        imageUrl: getCurrentProduct.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
        text: getCurrentProduct.title,
        color: color,
        textSize: 20,
        isTitle: true,
      ),
      trailing: InkWell(
          child: isInCart
              ? IconButton(
                  onPressed: () {
                    final User? user = authInstance.currentUser;
                    if(user ==null){
                      GlobalMethods.errorDialog(subtitle: 'No user found, login first', context: context);
                      return;
                    }
                    cartProvider.removeOneItem(getCurrentProduct.id);

                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        contentType: ContentType.success,
                        title: '${getCurrentProduct.title} removed from cart',
                        message: '',
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  icon: const Icon(
                    CupertinoIcons.minus_square_fill,
                    color: Colors.red,
                    size: 26,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    cartProvider.addProductsToCart(
                        productId: getCurrentProduct.id, quantity: 1);

                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        contentType: ContentType.success,
                        title: '${getCurrentProduct.title} added to cart',
                        message: '',
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  icon: const Icon(
                    CupertinoIcons.plus_app_fill,
                    color: Colors.green,
                    size: 28,
                  ),
                )),
    );
  }
}
