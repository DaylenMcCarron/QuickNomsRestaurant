import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/model/restaurantModel.dart';
import 'package:quicknomsrestaurant/view/signInLogicScreen/signInLogicScreen.dart';

class RestaurantCRUDServices {
  static RegisterRestaurant(RestaurantModel data, BuildContext context) async {
    try {
      await firestore
          .collection('Restaurant')
          .doc(auth.currentUser!.uid)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const SignInLogicScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
