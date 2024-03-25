import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quicknomsrestaurant/utils/colors.dart';
import 'package:quicknomsrestaurant/view/addFoodItem/addFoodItem.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const AddFoodItemScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        child: FaIcon(FontAwesomeIcons.plus, color: white),
      ),
      body: Center(
        child: Text('Menu Screen'),
      ),
    );
  }
}
