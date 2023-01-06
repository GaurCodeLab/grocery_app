import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'inner_screens/feedsScreen.dart';
import 'inner_screens/onsale_screen.dart';
import 'provider/dark_theme_provider.dart';
import 'screens/bottom_bar_scren.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const BottomBarScreen(),
          routes: {
            OnSaleScreen.routeName : (ctx) => const OnSaleScreen(),
            FeedsScreen.routeName : (ctx) => const FeedsScreen(),
            ProductDetails.routeName : (ctx) => const ProductDetails(),
            WishlistScreen.routeName : (ctx) => const WishlistScreen(),
          },
        );

      }),
    );
  }
}
