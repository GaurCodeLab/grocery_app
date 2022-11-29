import 'package:flutter/material.dart';

Future<dynamic> showAddressAlertDialogue(BuildContext context) {
  final TextEditingController addressTextController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Update Address'),
          content: TextField(
            controller: addressTextController,
            // onChanged: (value) {
            //   print('${addressTextController.text}');
            // },
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Your Address',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('update'),
            ),
          ],
        );
      });
}
