import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {
 CategoriesWidget({super.key, required this.catText, required this.imgPath, });
  final String catText, imgPath;
 

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white70 : Colors.black;
    return InkWell(
      onTap: () {
       // print('Category pressed');
      },
      child: Container(
        decoration: BoxDecoration(
            color:
                themeState.getDarkTheme ? Colors.grey[900] : Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: themeState.getDarkTheme
                    ? Colors.black
                    : Colors.grey.shade500,
                offset: const Offset(2, 2),
                blurRadius: 10,
                spreadRadius: 0.5,
              ),
              BoxShadow(
                color: themeState.getDarkTheme
                    ? Colors.grey.shade800
                    : Colors.white,
                offset: const Offset(-2, -2),
                blurRadius: 10,
                spreadRadius: 0.5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: screenWidth * 0.3,
                width: screenWidth * 0.3,
                decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 20,
              isTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
