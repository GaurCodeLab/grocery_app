import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/firebae_consts.dart';
import 'package:uuid/uuid.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Row(
              children: [
                const Icon(Icons.logout_rounded),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                ),
              ],
            ),
            content: Text(
              subtitle,
              style: const TextStyle(fontSize: 18.0),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              TextButton(
                onPressed: () {
                  fct();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'ok',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Row(
              children: const [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("An Error occured"),
                ),
              ],
            ),
            content: Text(
              subtitle,
              style: const TextStyle(fontSize: 18.0),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'ok',
                  style: TextStyle(fontSize: 18.0, color: Colors.cyan),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
       final snackBar =  SnackBar(
           elevation: 0,
           behavior: SnackBarBehavior.floating,
           backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
        title: 'Added to cart',
        message: '',
        contentType: ContentType.success,
      ));
     await ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
