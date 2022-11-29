// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/user_screen_listtile.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/widgets/show_address_alert_dialogue.dart';

import '../provider/dark_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Hi, ',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'MyName',
                        style: TextStyle(
                          color: color,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                TextWidget(
                  color: color,
                  text: 'Email@email.com',
                  textSize: 18,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                ),
                listTile(
                  leadinIcon: IconlyLight.profile,
                  title: 'Address',
                  subtitle: 'Subtitle here',
                  onPressed: () async {
                    await showAddressAlertDialogue(context);
                  },
                  color: color,
                ),
                listTile(
                  leadinIcon: IconlyLight.wallet,
                  title: 'Orders',
                  onPressed: () {},
                  color: color,
                ),
                listTile(
                  leadinIcon: IconlyLight.heart,
                  title: 'Wishlist',
                  onPressed: () {},
                  color: color,
                ),
                listTile(
                  leadinIcon: Icons.remove_red_eye_outlined,
                  title: 'Viewed',
                  onPressed: () {},
                  color: color,
                ),
                listTile(
                  leadinIcon: IconlyLight.unlock,
                  title: 'Forget password',
                  onPressed: () {},
                  color: color,
                ),
                SwitchListTile(
                  title: TextWidget(
                    color: color,
                    text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                    textSize: 24,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  value: themeState.getDarkTheme,
                  activeColor: themeState.getDarkTheme ? Colors.grey[500] : Colors.grey[300],
                ),
                listTile(
                  leadinIcon: IconlyLight.logout,
                  title: 'Logout',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: Row(children: const [
                              Icon(Icons.logout_rounded),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sign out'),
                              ),
                            ]),
                            content: Text('Do you want to Sign out?',
                                style: TextStyle(fontSize: 18.0),),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (Navigator.canPop(context)) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('cancel',
                                      style: TextStyle(fontSize: 18.0),),),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'ok',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
