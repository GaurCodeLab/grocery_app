import 'package:flutter/material.dart%20';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../widgets/on_sale.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/OnSaleScreen';
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          textSize: 24.0,
          text: 'Products on sale',
          color: color,
          isTitle: true,
        ),
      ),
      body: _isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/box.png'),
                    Text(
                      'No products on sale yet! \nStay tuned',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.50),
              children: List.generate(16, (index) {
                return const OnSaleWidget();
              }),
            ),
    );
  }
}
