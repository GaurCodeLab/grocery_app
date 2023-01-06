import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? Colors.grey[900] : Colors.grey[300],
      primaryColor: isDarkTheme ?  Colors.grey[900] : Colors.grey[300],
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary:
                isDarkTheme ? const Color(0xff1a1f3c) : const Color(0xffe9fcfc),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      cardColor:
          isDarkTheme ?  Colors.grey[900] : Colors.grey[350],
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      
    );
  }
}
