import 'package:flutter/material.dart%20';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_product_list_screen.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/on_sale.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = '/OnSaleScreen';
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
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
      body: productsOnSale.isEmpty
          ? const EmptyProductWidget(text: 'No products on sale yet! \nStay tuned',)
          : GridView.count(
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.50),
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productsOnSale[index],
                    child: const OnSaleWidget(),);
              },),
            ),
    );
  }
}
