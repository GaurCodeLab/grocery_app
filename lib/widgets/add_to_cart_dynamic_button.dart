import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebae_consts.dart';
import '../provider/cart_provider.dart';
import '../provider/dark_theme_provider.dart';
import '../services/global_methods.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({Key? key, required this.quantity}) : super(key: key);

  final String quantity;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: NeumorphicButton(
        onPressed: isInCart ? null
          :() {
          // if(_isInCart) {
          //   return;
          // }
          final User? user = authInstance.currentUser; 
          if(user ==null){
            GlobalMethods.errorDialog(subtitle: 'No user found, login first', context: context);
            return;
          }
          cartProvider.addProductsToCart(productId: productModel.id, quantity: int.parse(widget.quantity) );

          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.success,
              title: isInCart ? 'Already in cart' : 'Added to cart',
              message:
              isInCart ? '' : '${productModel.title} added to cart',
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        //print("item and its quantity are : item : ${productModel.id}, quantity: ${widget.quantity}");

        },
        style: NeumorphicStyle(
            color:
                themeState.getDarkTheme ? Colors.grey[900] : Colors.grey[300],
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(10),
            ),
            depth: 3,
            shadowLightColor:
                themeState.getDarkTheme ? Colors.grey[900] : Colors.grey[300],
            shape: NeumorphicShape.convex,
            intensity: 5),
        child: TextWidget(
          text: isInCart ? 'In cart' :'Add to cart',
          color: color,
          textSize: 18,
        ),
      ),

    );
  }
}
