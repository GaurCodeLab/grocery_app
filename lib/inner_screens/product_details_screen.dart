import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/add_quantity_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/quantity_controller_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
    final Color color = Utils(context).color;
    final Color subtitleColor = Utils(context).subtitleColor;
    Size size = Utils(context).getScreenSize;
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
              boxFit: BoxFit.scaleDown,
              width: size.width,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                TextWidget(
                                  text: 'Title',
                                  color: color,
                                  textSize: 25,
                                  isTitle: true,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                TextWidget(
                                  text: '\u{20B9}150',
                                  color: Colors.green,
                                  textSize: 22,
                                  isTitle: true,
                                ),
                                TextWidget(
                                  text: '/kg',
                                  color: color,
                                  textSize: 14,
                                  isTitle: false,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Visibility(
                                  visible: true,
                                  child: Text(
                                    '\u{20B9}130',
                                    style:
                                        TextStyle(fontSize: 16, color: color),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.heart,
                                size: 24,
                                color: color,
                              ),
                              // padding: EdgeInsets.only(left:20.0, right: 10),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(63, 200, 101, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextWidget(
                                text: 'Free delivery',
                                textSize: 20,
                                color: Colors.white,
                                isTitle: true,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QuantityController(
                        fct: () {
                          if (_quantityTextController.text == '1') {
                            return;
                          } else {
                            setState(() {
                              _quantityTextController.text =
                                  (int.parse(_quantityTextController.text) - 1)
                                      .toString();
                            });
                          }
                        },
                        icon: CupertinoIcons.minus_square,
                        color: Colors.red,
                      ),
                      Flexible(
                        child: TextField(
                          controller: _quantityTextController,
                          key: const ValueKey('quantity'),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityTextController.text = '1';
                              } else {}
                            });
                          },
                        ),
                      ),
                      QuantityController(
                        fct: () {
                          setState(() {
                            _quantityTextController.text =
                                (int.parse(_quantityTextController.text) + 1)
                                    .toString();
                          });
                        },
                        icon: CupertinoIcons.plus_square,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextWidget(
                              text: 'Total',
                              color: Colors.green,
                              textSize: 18,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                TextWidget(
                                  text: '\u{20B9}150/',
                                  color: color,
                                  textSize: 18,
                                  isTitle: true,
                                ),
                                TextWidget(
                                  text: '${_quantityTextController.text}kg',
                                  color: color,
                                  textSize: 14,
                                  isTitle: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextWidget(
                                text: 'Add to cart',
                                textSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
