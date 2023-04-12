import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/dark_theme_provider.dart';

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

          cartProvider.addProductsToCart(productId: productModel.id, quantity: int.parse(widget.quantity) );
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
      // TextButton(
      //   child: TextWidget(text: 'Add item', color: color, textSize: 18),
      //   onPressed: () {
      //     setState(() {
      //       quantity++;
      //     });
      //   },
      // )
      //  Container(
      //     decoration: BoxDecoration(
      //       color: themeState.getDarkTheme
      //           ? Colors.grey[900]
      //           : Colors.grey[300],
      //       borderRadius: BorderRadius.circular(30),
      //       boxShadow: [
      //         BoxShadow(
      //           color: themeState.getDarkTheme
      //               ? Colors.black
      //               : Colors.grey.shade500,
      //           offset: const Offset(2, 2),
      //           blurRadius: 10,
      //           spreadRadius: 0.5,
      //         ),
      //         BoxShadow(
      //           color: themeState.getDarkTheme
      //               ? Colors.grey.shade800
      //               : Colors.white,
      //           offset: const Offset(-2, -2),
      //           blurRadius: 10,
      //           spreadRadius: 0.5,
      //         ),
      //       ],
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         IconButton(
      //           icon: Icon(
      //             Icons.remove_circle_rounded,
      //             color: color,
      //             size: 22,
      //           ),
      //           onPressed: () {
      //             setState(() {
      //               quantity--;
      //             });
      //           },
      //         ),
      //         Text(
      //           quantity.toString(),
      //           style: const TextStyle(fontSize: 18),
      //         ),
      //         IconButton(
      //           icon: Icon(
      //             Icons.add_circle_rounded,
      //             color: color,
      //             size: 22,
      //           ),
      //           onPressed: () {
      //             setState(() {
      //               quantity++;
      //             });
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}
