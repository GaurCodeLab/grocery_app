import 'package:flutter/material.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/add_to_cart_dynamic_button.dart';
import 'package:provider/provider.dart';

class PriceWidget extends StatelessWidget {

  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,

      required this.isOnSale});
  final double salePrice, price;

  final bool isOnSale;

  @override
  Widget build(BuildContext context) {

    final color = Utils(context).color;
    double userPrice = isOnSale ? salePrice : price;

    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale ? true :false,
          child: Text(
            '\u{20B9}$price',
            style: TextStyle(
                fontSize: 15,
                color: color,
                decoration: TextDecoration.lineThrough),
          ),
        ),
        const SizedBox(width: 5,),
        TextWidget(
          text: '\u{20B9}$userPrice',
          color: Colors.green,
          textSize: 18,
          isTitle: true,
        ),

      ],
    );
  }
}
