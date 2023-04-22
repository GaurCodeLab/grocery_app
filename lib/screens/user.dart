// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/auth/forget_password_screen.dart';
import 'package:grocery_app/screens/auth/login_screen.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/user_screen_listtile.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/widgets/show_address_alert_dialogue.dart';

import '../consts/firebae_consts.dart';
import '../provider/dark_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  final User? user = authInstance.currentUser;
  bool _isLoading = false;
  String? _email;
  String? _name;
  String? _address;

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        _address = userDoc.get('shipping-address');
        _addressTextController.text = userDoc.get('shipping-address');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: LoadingManager(
        isloading: _isLoading,
        child: Center(
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
                          text: _name ?? 'user',
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
                    text: _email ?? 'email@email.com',
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
                    subtitle: _address,
                    onPressed: () async {
                      await showAddressAlertDialogue(context, _addressTextController);
                      setState(() {
                        _address = _addressTextController.text;
                      });
                    },
                    color: color,
                  ),
                  listTile(
                    leadinIcon: IconlyLight.wallet,
                    title: 'Orders',
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: OrderScreen.routeName);
                    },
                    color: color,
                  ),
                  listTile(
                    leadinIcon: IconlyLight.heart,
                    title: 'Wishlist',
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: WishlistScreen.routeName);
                    },
                    color: color,
                  ),
                  listTile(
                    leadinIcon: Icons.remove_red_eye_outlined,
                    title: 'Viewed',
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context,
                          routeName: ViewedRecentlyScreen.routeName);
                    },
                    color: color,
                  ),
                  listTile(
                    leadinIcon: IconlyLight.unlock,
                    title: 'Forget password',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen()));
                    },
                    color: color,
                  ),
                  SwitchListTile(
                    title: TextWidget(
                      color: color,
                      text:
                          themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
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
                    activeColor: themeState.getDarkTheme
                        ? Colors.grey[500]
                        : Colors.grey[300],
                  ),
                  listTile(
                    leadinIcon:
                        user == null ? IconlyLight.login : IconlyLight.logout,
                    title: user == null ? 'Login' : 'Logout',
                    onPressed: () {
                      if (user == null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                        return;
                      }
                      GlobalMethods.warningDialog(
                          title: 'Logout',
                          subtitle: 'Do want to sign out?',
                          fct: () async {
                            await authInstance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                          },
                          context: context);
                    },
                    color: color,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
