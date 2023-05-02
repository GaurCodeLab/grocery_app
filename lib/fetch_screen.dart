import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/screens/bottom_bar_scren.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'consts/constss.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {

  List<String> images = Constss.authImagePaths;

  @override
  void initState() {
      images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async{
      final productProvider = Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
     await productProvider.fetchProducts();
     await cartProvider.fetchCart();
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomBarScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(images[0], fit: BoxFit.cover, height: double.infinity,),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
