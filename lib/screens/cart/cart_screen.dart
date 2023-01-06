import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeState.getDarkTheme ? Colors.black : Colors.white,
        title: TextWidget(
          text: 'My Cart (2)',
          color: color,
          textSize: 22,
          isTitle: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods.warningDialog(
                  title: 'Empty cart',
                  subtitle: 'Do you want to empty cart?',
                  fct: () {},
                  context: context);
            },
            icon: Icon(
              IconlyBroken.delete,
              color: color,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _checkOut(context: context),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CartWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkOut({required BuildContext context}) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Oder Now',
                    textSize: 20,
                    color: color,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
                child: TextWidget(
              text: 'Total: \u{20B9}200',
              color: color,
              textSize: 18,
              isTitle: true,
            )),
          ],
        ),
      ),
    );
  }
}
