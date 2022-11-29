import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({Key? key}) : super(key: key);


  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  int quantity = 0;
  @override
  void initState() {
    quantity = 0;
    super.initState();
  }

  // @override
  // void dispose(){
  //   quantity.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: quantity == 0
          ? NeumorphicButton(
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
              style: NeumorphicStyle(
                  color: themeState.getDarkTheme
                      ? Colors.grey[900]
                      : Colors.grey[300],
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  depth: 3,
                  shadowLightColor: themeState.getDarkTheme
                      ? Colors.grey[900]
                      : Colors.grey[300],
                  shape: NeumorphicShape.convex,
                  intensity: 5),
              child: TextWidget(
                text: 'Add',
                color: color,
                textSize: 18,
              ))
          // TextButton(
          //   child: TextWidget(text: 'Add item', color: color, textSize: 18),
          //   onPressed: () {
          //     setState(() {
          //       quantity++;
          //     });
          //   },
          // )
          : Container(
              decoration: BoxDecoration(
                color: themeState.getDarkTheme
                    ? Colors.grey[900]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: themeState.getDarkTheme
                        ? Colors.black
                        : Colors.grey.shade500,
                    offset: const Offset(2, 2),
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  ),
                  BoxShadow(
                    color: themeState.getDarkTheme
                        ? Colors.grey.shade800
                        : Colors.white,
                    offset: const Offset(-2, -2),
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle_rounded,
                      color: color,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity--;
                      });
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_rounded,
                      color: color,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
