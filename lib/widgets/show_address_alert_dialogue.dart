import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/global_methods.dart';

import '../consts/firebae_consts.dart';

Future<dynamic> showAddressAlertDialogue(BuildContext context,TextEditingController addressTextController) {
  //final TextEditingController addressTextController = TextEditingController();
  final User? user = authInstance.currentUser;
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
              onPressed: () async {
                String _uid = user!.uid;
                try{

                  await FirebaseFirestore.instance.collection('users').doc(_uid).update(
                      {'shipping-address' : addressTextController.text});
                  Navigator.pop(context);


                }catch(err){
                  GlobalMethods.errorDialog(subtitle: '$err', context: context);
                }

              },
              child: const Text('update'),
            ),
          ],
        );
      });
}
