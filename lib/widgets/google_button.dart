import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'assets/images/google.png',
                width: 40,
              ),
            ),
            const SizedBox(width: 10,),
            TextWidget(
              textSize: 18,
              text: 'Sign in with google',
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
