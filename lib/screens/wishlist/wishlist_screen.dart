import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
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
    // bool _isEmpty = true;
    final Color color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsLists =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsLists.isEmpty
        ? const EmptyScreen(
            title: 'Your Wishlist is empty!',
            subtitle: 'Add something to wishlist :)',
            buttonText: 'Browse products',
            imagePath: 'assets/images/wishlist.png',
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor:
                  themeState.getDarkTheme ? Colors.black : Colors.white,
              centerTitle: true,
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              title: TextWidget(
                text: 'My Wishlist(${wishlistItemsLists.length})',
                color: color,
                textSize: 22,
                isTitle: false,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Clear wishlist',
                        subtitle: 'Do you want to clear wishlist?',
                        fct: () {
                          wishlistProvider.clearWishlist();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                itemCount: wishlistItemsLists.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: wishlistItemsLists[index],
                        child: const WishlistWidget());
                  }),
            ),
          );
  }
}
