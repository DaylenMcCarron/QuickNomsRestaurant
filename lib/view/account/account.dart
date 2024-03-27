import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:provider/provider.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/controller/provider/FoodProvider/FoodProvider.dart';
import 'package:quicknomsrestaurant/controller/provider/restaurantRegisterProvider/restaurantRegisterProvider.dart';
import 'package:quicknomsrestaurant/controller/services/authServices/mobileAuthServices.dart';
import 'package:quicknomsrestaurant/controller/services/locationServices/locationServices.dart';
import 'package:quicknomsrestaurant/utils/textStyles.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RestaurantProvider>().getRestaurantData();
    });
  }

  List account = [
    [FontAwesomeIcons.shop, 'Orders'],
    [FontAwesomeIcons.heart, 'Your favourites'],
    [FontAwesomeIcons.star, 'Restaurant Rewards'],
    [FontAwesomeIcons.wallet, 'Wallet'],
    [FontAwesomeIcons.gift, 'Send a gift'],
    [FontAwesomeIcons.suitcase, 'Buisness preferences'],
    [FontAwesomeIcons.person, 'Help'],
    [FontAwesomeIcons.tag, 'Promotion'],
    [FontAwesomeIcons.ticket, 'Uber Pass'],
    [FontAwesomeIcons.suitcase, 'Deliver with uber'],
    [FontAwesomeIcons.gear, 'Settings'],
    [FontAwesomeIcons.powerOff, 'Sign Out'],
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Consumer<RestaurantProvider>(
                builder: (context, restaurantProvider, child) {
              if (restaurantProvider.restaurantData == null) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 3.h,
                      backgroundColor: Colors.black54,
                      child: CircleAvatar(
                        radius: 3.h - 1,
                        backgroundColor:
                            const Color.fromARGB(255, 240, 240, 240),
                        child: FaIcon(
                          FontAwesomeIcons.user,
                          size: 3.h,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      'Username',
                      style: AppTextStyles.body16,
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      restaurantProvider.restaurantData!.restaurantName!,
                      style: AppTextStyles.heading26Bold,
                    )
                  ],
                );
              }
            }),
            SizedBox(
              height: 4.h,
            ),
            ListView.builder(
                itemCount: account.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (index == (account.length - 1)) {
                        MobileAuthServices.signOut(context);
                      }
                      if (index == 2) {
                        GeoFirePoint myLocation = geo.point(
                            latitude: 12.960632, longitude: 77.641603);
                        firestore.collection('locations').add({
                          'name': 'random name',
                          'position': myLocation.data
                        });
                      }
                    },
                    leading: FaIcon(
                      account[index][0],
                      size: 2.h,
                    ),
                    title: Text(
                      account[index][1],
                      style: AppTextStyles.body14,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
