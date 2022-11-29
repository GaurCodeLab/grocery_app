import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/categories_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key});

   

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath' : 'assets/images/cat/fruits.png',
      'catText' : 'Fruits',

    },
    {
      'imgPath' : 'assets/images/cat/veg.png',
      'catText' : 'Vegetables',

    },
    {
      'imgPath' : 'assets/images/cat/spinach.png',
      'catText' : 'Herbs',

    },
    {
      'imgPath': 'assets/images/cat/nuts.png',
      'catText': 'Nuts',
    },
    {
      'imgPath' : 'assets/images/cat/spices.png',
      'catText' : 'Spices',
    },
    {
      'imgPath' : 'assets/images/cat/grains.png',
      'catText' : 'Grains',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: themeState.getDarkTheme ? Colors.black : Colors.white,
        title: TextWidget(
          text: 'Categories',
          color: utils.titleColor,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          children: List.generate(6, (index) {
            return  CategoriesWidget(
              catText: catInfo[index]['catText'],
              imgPath: catInfo[index]['imgPath'],
              
            );
          }),
        ),
      ),
    );
  }
}
