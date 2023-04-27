// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/constss.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items.dart';
import 'package:grocery_app/widgets/on_sale.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart/';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../inner_screens/feedsScreen.dart';
import '../inner_screens/onsale_screen.dart';
import '../provider/dark_theme_provider.dart';
import '../services/global_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = Utils(context).color;

    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: size.height * 0.33,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      Constss.offerImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: Constss.offerImages.length,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.blue),
                  ),
                  control: const SwiperControl(color: Colors.blue),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                GlobalMethods.navigateTo(
                    ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: TextWidget(
                  text: 'View all', color: Colors.blue, textSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        TextWidget(
                          text: 'On Sale '.toUpperCase(),
                          color: Colors.red,
                          textSize: 22,
                          isTitle: true,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          IconlyLight.discount,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: size.height * 0.22,
                      child: ListView.builder(
                        cacheExtent: 1000,
                        itemCount: productsOnSale.length < 10
                            ? productsOnSale.length
                            : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: ChangeNotifierProvider.value(
                              value: productsOnSale[index],
                              child: OnSaleWidget(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextWidget(
                    text: 'Our Products',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: FeedsScreen.routeName);
                  },
                  child: TextWidget(
                    text: 'See all',
                    color: Colors.blue,
                    textSize: 20,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
              child: GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: size.width / (size.height * 0.70),
                children: List.generate(
                    allProducts.length < 4 ? allProducts.length : 4, (index) {
                  return ChangeNotifierProvider.value(
                    value: allProducts[index],
                    child: FeedWidget(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
