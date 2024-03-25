import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/controller/services/toastServices/toastMessageService.dart';

class ImageServices {
  static getImagesFromGallery({required BuildContext context}) async {
    List<File> selectedImages = [];
    final pickedFile = await picker.pickMultiImage(imageQuality: 100);
    List<XFile> filePick = pickedFile;
    if (filePick.isNotEmpty) {
      for (var image in filePick) {
        selectedImages.add(File(image.path));
      }
    } else {
      ToastService.sendScaffoldAlert(
          msg: 'No images selected', toastStatus: 'WARNING', context: context);
    }
    log('The Images are \n ${selectedImages.toList().toString()}');
    return selectedImages;
  }

  static uploadImagesToFirebaseStorageAndGetURL(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesURL = [];
    String sellerUID = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref =
          storage.ref().child('RestaurantBannerImages').child(imageName);
      await ref.putFile(File(image.path));
      String imageURL = await ref.getDownloadURL();
      imagesURL.add(imageURL);
    });
    return imagesURL;
  }

  static pickSingleImage({required BuildContext context}) async {
    File? selectedImage;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    XFile? filePick = pickedFile;
    if (filePick != null) {
      selectedImage = File(filePick.path);
      return selectedImage;
    } else {
      ToastService.sendScaffoldAlert(
          msg: 'No images selected', toastStatus: 'WARNING', context: context);
    }
  }
}
