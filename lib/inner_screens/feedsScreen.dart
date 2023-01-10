import 'package:flutter/material.dart%20';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/feed_items.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/FeedsScreen';

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          textSize: 20.0,
          text: 'All products',
          color: color,
          isTitle: true,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.bag2,
                    color: color,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.heart,
                    color: color,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    color: themeState.getDarkTheme
                        ? Colors.grey[900]
                        : Colors.grey[300],
                    intensity: -2,
                    depth: 3,
                  ),
                  child: TextField(
                    focusNode: _searchTextFocusNode,
                    controller: _searchTextController,
                    onChanged: (valuee) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Colors.greenAccent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Colors.greenAccent, width: 1),
                      ),
                      hintText: "What's on your mind?",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: _searchTextFocusNode.hasFocus
                              ? Colors.red
                              : color,
                        ),
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTextFocusNode.unfocus();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / (size.height * 0.70),
              children: List.generate(16, (index) {
                return const FeedWidget();
              }),
            ),
          ],
        ),
      ),
    );
  }
}