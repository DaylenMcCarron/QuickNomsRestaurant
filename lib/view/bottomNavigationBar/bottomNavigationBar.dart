import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:quicknomsrestaurant/menuScreen/menuScreen.dart';
import 'package:quicknomsrestaurant/statusScreen/statusScreen.dart';
import 'package:quicknomsrestaurant/view/account/account.dart';
import 'package:quicknomsrestaurant/view/addFoodItem/addFoodItem.dart';
import 'package:quicknomsrestaurant/view/home/homeScreen.dart';
import 'package:quicknomsrestaurant/view/restaurantRegistrationScreen/restaurantRegistrationScreen.dart';

class BottomNavigationBarQuickNoms extends StatefulWidget {
  const BottomNavigationBarQuickNoms({super.key});

  @override
  State<BottomNavigationBarQuickNoms> createState() =>
      _BottomNavigationBarQuickNomsState();
}

class _BottomNavigationBarQuickNomsState
    extends State<BottomNavigationBarQuickNoms> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: const MenuScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.list),
            title: "Menu",
          ),
        ),
        PersistentTabConfig(
          screen: const StatusScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.bar_chart_sharp),
            title: "Status",
          ),
        ),
        // PersistentTabConfig(
        //   screen: const BasketScreen(),
        //   item: ItemConfig(
        //     icon: const Icon(Icons.shopping_cart),
        //     title: "Basket",
        //   ),
        // ),
        PersistentTabConfig(
          screen: const AccountScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.account_circle),
            title: "Account",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
