import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/controller/services/toastServices/toastMessageService.dart';
import 'package:quicknomsrestaurant/model/addFoodModel/addFoodModel.dart';

class FoodDataCRUDServices {
  static uploadFoodData(BuildContext context, AddFoodModel data) async {
    try {
      await firestore
          .collection('Food')
          .doc(data.foodID)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pop(context);
        ToastService.sendScaffoldAlert(
            msg: 'Food Added Successfully',
            toastStatus: 'SUCCESS',
            context: context);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
