import 'package:flutter/material.dart';

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
            title: Row(children:  [
              const Icon(Icons.logout_rounded),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              ),
            ],),
            content:  Text(
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
}
