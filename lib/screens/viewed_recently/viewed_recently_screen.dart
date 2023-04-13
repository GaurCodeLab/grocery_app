import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/viewed_provider.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedItemsLists =
        viewedProvider.getViewedItems.values.toList().reversed.toList();

    return viewedItemsLists.isEmpty
        ? const EmptyScreen(
            title: "You haven't viewed anything recently!",
            subtitle: 'Browse all products :)',
            buttonText: 'Shop now',
            imagePath: 'assets/images/history.png',
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor:
                  themeState.getDarkTheme ? Colors.black : Colors.white,
              centerTitle: true,
              title: TextWidget(
                text: 'Viewed recently',
                color: color,
                textSize: 22,
                isTitle: true,
              ),
              leading: const BackWidget(),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Empty cart',
                        subtitle: 'Do you want to clear viewed history?',
                        fct: () {
                          viewedProvider.clearViewedItems();
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
              child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                      child: ChangeNotifierProvider.value(
                          value: viewedItemsLists[index],
                          child: const ViewedRecentlyWidget()),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: color,
                    );
                  },
                  itemCount: viewedItemsLists.length),
            ),
          );
  }
}
