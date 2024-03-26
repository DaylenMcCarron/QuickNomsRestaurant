import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quicknomsrestaurant/controller/services/imageServices/imageServices.dart';
import 'package:quicknomsrestaurant/controller/services/restaurantCRUDServices/restaurantCRUDServices.dart';
import 'package:quicknomsrestaurant/model/restaurantModel.dart';

class RestaurantProvider extends ChangeNotifier {
  List<File> restaurantBannerImages = [];
  List<String> restaurantBannerImagesURL = [];
  RestaurantModel? restaurantData;

  getRestaurantBannerImages(BuildContext context) async {
    restaurantBannerImages =
        await ImageServices.getImagesFromGallery(context: context);
    notifyListeners();
  }

  updateRestaurantBannerImagesURL(BuildContext context) async {
    restaurantBannerImagesURL =
        await ImageServices.uploadImagesToFirebaseStorageAndGetURL(
            images: restaurantBannerImages, context: context);
    notifyListeners();
  }

  getRestaurantData() async {
    restaurantData = await RestaurantCRUDServices.fetchRestrauntData();
    notifyListeners();
  }
}
