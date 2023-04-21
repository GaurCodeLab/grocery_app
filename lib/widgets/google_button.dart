import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/consts/firebae_consts.dart';
import 'package:grocery_app/screens/bottom_bar_scren.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/global_methods.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);
  //bool _isLoading = false;

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BottomBarScreen()));
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              subtitle: "${error.message}", context: context);
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: "$error", context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
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
            const SizedBox(
              width: 10,
            ),
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
