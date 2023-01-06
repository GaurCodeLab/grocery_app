import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../provider/dark_theme_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreenScreen';

  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeState.getDarkTheme ? Colors.black : Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: TextWidget(
          text: 'Wishlist (2)',
          color: color,
          textSize: 22,
          isTitle: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods.warningDialog(
                  title: 'Clear wishlist',
                  subtitle: 'Do you want to clear wishlist?',
                  fct: () {},
                  context: context);
            },
            icon: Icon(
              IconlyBroken.delete,
              color: color,
            ),
          ),
        ],
        leading: const BackWidget(),
      ),
      body: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          }),
    );
  }
}
