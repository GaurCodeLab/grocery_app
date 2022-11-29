import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class listTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData leadinIcon;
  final Function onPressed;
  final Color color;

  const listTile({
    required this.title,
    required this.leadinIcon,
    required this.onPressed,
    this.subtitle,
    required this.color,
  });

  @override
  State<listTile> createState() => _listTileState();
}

class _listTileState extends State<listTile> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return ListTile(
      title: TextWidget(
        color: color,
        text:widget.title,
        textSize: 24,
       // isTitle: true,
      ),
      subtitle: TextWidget(
        color: color,
        text: widget.subtitle ?? '',
        textSize: 18,
      ),
      leading: Icon(widget.leadinIcon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        widget.onPressed();
      },
    );
  }
}
