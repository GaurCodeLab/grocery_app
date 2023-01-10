import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/inner_screens/feedsScreen.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText})
      : super(key: key);
  final String imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    //final themeState = Utils(context).getTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Whoops!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(text: title, color: color, textSize: 20),

              const SizedBox(
                height: 20,
              ),
              TextWidget(text: subtitle, color: color, textSize: 20),
              SizedBox(
                height: size.height * 0.1,
              ),
              NeumorphicButton(
                style: NeumorphicStyle(
                    color: themeState.getDarkTheme
                        ? Colors.grey[900]
                        : Colors.grey[300],
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    depth: 3,
                    shadowLightColor: themeState.getDarkTheme
                        ? Colors.grey[900]
                        : Colors.grey[300],
                    shape: NeumorphicShape.convex,
                    intensity: 5),
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: FeedsScreen.routeName);
                },
                child: TextWidget(
                  text: buttonText,
                  color: themeState.getDarkTheme
                      ? Colors.grey.shade300
                      : Colors.grey.shade600,
                  textSize: 20,
                  isTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
