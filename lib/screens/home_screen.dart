// ignore_for_file: prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items.dart';
import 'package:grocery_app/widgets/on_sale.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../inner_screens/onsale_screen.dart';
import '../provider/dark_theme_provider.dart';
import '../services/global_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = Utils(context).color;

    Size size = Utils(context).getScreenSize;


    return Scaffold(
      // appBar: AppBar(
      //   title: TextWidget(
      //       text: 'Grocery Shop',
      //       color: themeState.getDarkTheme ? Colors.white : Colors.black,
      //       textSize: 24),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
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
                      _offerImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: _offerImages.length,
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
              onPressed: (){
                GlobalMethods.navigateTo(ctx: context, routeName: OnSaleScreen.routeName);

                    
              },
              child: TextWidget(text: 'View all', color: Colors.blue, textSize: 22),
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
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: OnSaleWidget(),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width:5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextWidget(
                    text: 'Our Products',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: 'See all',
                    color: Colors.blue,
                    textSize: 20,
                  ),
                )
              ],
            ),

            Padding(
              padding:  EdgeInsets.zero,
              child: GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: size.width /(size.height*0.70),
                children:  List.generate(4, (index) {
                  return FeedWidget();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
