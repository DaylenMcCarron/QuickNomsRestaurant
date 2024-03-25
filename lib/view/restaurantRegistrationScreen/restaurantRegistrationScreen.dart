import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/controller/services/imageServices/imageServices.dart';
import 'package:quicknomsrestaurant/controller/services/locationServices/locationServices.dart';
import 'package:quicknomsrestaurant/controller/services/restaurantCRUDServices/restaurantCRUDServices.dart';
import 'package:quicknomsrestaurant/model/address.dart';
import 'package:quicknomsrestaurant/model/restaurantModel.dart';
import 'package:quicknomsrestaurant/utils/colors.dart';
import 'package:quicknomsrestaurant/utils/textStyles.dart';
import 'package:quicknomsrestaurant/widgits/textfieldWidget.dart';
import 'package:sizer/sizer.dart';

import '../../controller/provider/restaurantRegisterProvider/restaurantRegisterProvider.dart';

class RestaurantRegistrationScreen extends StatefulWidget {
  const RestaurantRegistrationScreen({super.key});

  @override
  State<RestaurantRegistrationScreen> createState() =>
      _RestaurantRegistrationScreenState();
}

class _RestaurantRegistrationScreenState
    extends State<RestaurantRegistrationScreen> {
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantLicenseNumberController =
      TextEditingController();
  CarouselController controller = CarouselController();
  bool pressedRestrauntRegisterButton = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Consumer<RestaurantRegisterProvider>(
              builder: (context, registrationProvider, child) {
                if (registrationProvider.restaurantBannerImages.isEmpty) {
                  return InkWell(
                    onTap: () async {
                      await registrationProvider
                          .getRestaurantBannerImages(context);
                    },
                    child: Container(
                      height: 20.h,
                      width: 94.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: greyShade3,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 5.h,
                            width: 5.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: black),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              size: 3.h,
                              color: black,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Add',
                            style: AppTextStyles.body14,
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  List<File> bannerImages =
                      registrationProvider.restaurantBannerImages;
                  return Container(
                    height: 23.h,
                    width: 94.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: greyShade3),
                    child: CarouselSlider(
                      carouselController: controller,
                      options: CarouselOptions(
                        height: 23.h,
                        autoPlay: true,
                        viewportFraction: 1,
                      ),
                      items: bannerImages
                          .map(
                            (image) => Container(
                              width: 94.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(image), fit: BoxFit.cover),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 4.h,
            ),
            CommonTextfield(
              controller: restaurantNameController,
              title: 'Restaurant Name',
              hintText: 'Restaurant Name',
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 2.h,
            ),
            CommonTextfield(
              controller: restaurantLicenseNumberController,
              title: 'Registration Number',
              hintText: 'Registration Number',
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  pressedRestrauntRegisterButton = true;
                });
                await context
                    .read<RestaurantRegisterProvider>()
                    .updateRestaurantBannerImagesURL(context);
                Position currentAddress =
                    await LocationServices.getCurrentLocation();
                LocationServices.registerRestaurantLocationInGeofire();
                RestaurantModel data = RestaurantModel(
                  restaurantName: restaurantNameController.text.trim(),
                  restaurantLicenseNumber:
                      restaurantLicenseNumberController.text.trim(),
                  restaurantUID: auth.currentUser!.uid,
                  bannerImages: context
                      .read<RestaurantRegisterProvider>()
                      .restaurantBannerImagesURL,
                  address: AddressModel(
                      latitude: currentAddress.latitude,
                      longitude: currentAddress.longitude),
                );
                RestaurantCRUDServices.RegisterRestaurant(data, context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: black, minimumSize: Size(90.w, 6.h)),
              child: pressedRestrauntRegisterButton
                  ? CircularProgressIndicator(
                      color: white,
                    )
                  : Text(
                      'Register',
                      style: AppTextStyles.body16Bold.copyWith(color: white),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
