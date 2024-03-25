import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quicknomsrestaurant/controller/services/imageServices/imageServices.dart';

class AddFoodProvider extends ChangeNotifier {
  File? foodImage;
  String? foodImageURL;

  pickFoodImageFromGallery(BuildContext context) async {
    foodImage = await ImageServices.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async {
    List<String> url =
        await ImageServices.uploadImagesToFirebaseStorageAndGetURL(
            images: [foodImage!], context: context);
    if (url.isNotEmpty) {
      foodImageURL = url[0];
      log(foodImageURL!);
    }
    notifyListeners();
  }
}
