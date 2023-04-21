import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {Key? key,
      required this.fct,
      required this.buttonText,
        required this.buttonTextColor,
      required this.primary})
      : super(key: key);

  final Function fct;
  final String buttonText;
  final Color primary;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: NeumorphicButton(
        style: NeumorphicStyle(
            color: // Colors.grey[900]
                primary,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            depth: 3,
            shadowLightColor: Colors.grey[900],
            // Colors.grey[300],
            shape: NeumorphicShape.convex,
            intensity: 5),
        onPressed: () {
          fct();
          },
        child: Center(
          child: TextWidget(
            text: buttonText,
            color: buttonTextColor,
            textSize: 18,
            isTitle: true,
          ),
        ),
      ),
    );
  }
}
