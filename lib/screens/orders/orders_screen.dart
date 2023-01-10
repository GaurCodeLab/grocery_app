import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/orders/orders_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/OrderScreen';

  const OrderScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    final Color color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    return _isEmpty ? const  EmptyScreen(
      title: "You haven't ordered anything yet!",
      subtitle: 'Order something for yourself or family :)',
      buttonText: 'Shop now',
      imagePath: 'assets/images/box.png',
    ) :Scaffold(
      appBar: AppBar(
        backgroundColor: themeState.getDarkTheme ? Colors.black : Colors.white,
        centerTitle: true,
        title: TextWidget(
          text: 'My Orders',
          color: color,
          textSize: 22,
          isTitle: true,
        ),
        leading: const BackWidget(),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: OrderWidget(),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: color,
            );
          },
          itemCount: 10),
    );
  }
}
