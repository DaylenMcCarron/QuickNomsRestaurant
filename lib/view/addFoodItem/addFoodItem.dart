import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/controller/provider/FoodProvider/FoodProvider.dart';
import 'package:quicknomsrestaurant/controller/services/foodDataCRUDServices/foodDataCRUDServices.dart';
import 'package:quicknomsrestaurant/model/FoodModel/FoodModel.dart';
import 'package:quicknomsrestaurant/utils/colors.dart';
import 'package:quicknomsrestaurant/utils/textStyles.dart';
import 'package:quicknomsrestaurant/widgits/commonElevatedButton.dart';
import 'package:quicknomsrestaurant/widgits/textfieldWidget.dart';
import 'package:sizer/sizer.dart';

class AddFoodItemScreen extends StatefulWidget {
  const AddFoodItemScreen({super.key});

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();
  TextEditingController actualPriceController = TextEditingController();
  TextEditingController discountedPriceController = TextEditingController();
  bool foodIsPureVeg = true;
  bool pressedAddFoodItemButton = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Consumer<FoodProvider>(builder: (context, addFoodProvider, child) {
              return InkWell(
                  onTap: () async {
                    await addFoodProvider.pickFoodImageFromGallery(context);
                  },
                  child: Container(
                    height: 20.h,
                    width: 94.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      color: greyShade3,
                    ),
                    child: Builder(
                      builder: (context) {
                        if (addFoodProvider.foodImage != null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Image(
                              image: FileImage(addFoodProvider.foodImage!),
                              fit: BoxFit.contain,
                            ),
                          );
                        } else {
                          return Column(
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
                          );
                        }
                      },
                    ),
                  ));
            }),
            SizedBox(
              height: 4.h,
            ),
            CommonTextfield(
              controller: foodNameController,
              title: 'Name',
              hintText: 'Food Name',
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 2.h,
            ),
            CommonTextfield(
              controller: foodDescriptionController,
              title: 'Description',
              hintText: 'Food Description',
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 2.h,
            ),
            CommonTextfield(
              controller: actualPriceController,
              title: 'Actual price',
              hintText: 'Actual Food Price',
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2.h,
            ),
            CommonTextfield(
              controller: discountedPriceController,
              title: 'Discounted price',
              hintText: 'Discounted Food Price',
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Food is Vegetarian',
              style: AppTextStyles.body16Bold,
            ),
            SizedBox(
              height: 0.8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      foodIsPureVeg = true;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 3.h,
                        width: 3.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: foodIsPureVeg
                              ? Colors.green.shade100
                              : transparent,
                          borderRadius: BorderRadiusDirectional.circular(3.sp),
                          border: Border.all(
                            color: foodIsPureVeg ? black : grey,
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          size: 2.h,
                          color: foodIsPureVeg ? black : transparent,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        'Vegetarian',
                        style: AppTextStyles.body14,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      foodIsPureVeg = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 3.h,
                        width: 3.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !foodIsPureVeg
                              ? Colors.red.shade100
                              : transparent,
                          borderRadius: BorderRadiusDirectional.circular(3.sp),
                          border: Border.all(
                            color: !foodIsPureVeg ? black : grey,
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          size: 2.h,
                          color: !foodIsPureVeg ? black : transparent,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        'Non-Vegetarian',
                        style: AppTextStyles.body14,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            CommonElevatedButton(
              onPressed: () async {
                setState(() {
                  pressedAddFoodItemButton = true;
                });
                await context
                    .read<FoodProvider>()
                    .uploadImageAndGetImageURL(context);
                String foodID = uuid.v1().toString();
                FoodModel data = FoodModel(
                  name: foodNameController.text.trim(),
                  foodID: foodID,
                  uploadTime: Timestamp.now(),
                  restaurantUID: auth.currentUser!.uid,
                  description: foodDescriptionController.text.trim(),
                  foodImageURL: context.read<FoodProvider>().foodImageURL!,
                  isVegetarian: foodIsPureVeg,
                  actualPrice: actualPriceController.text.trim(),
                  discountedPrice: discountedPriceController.text.trim(),
                );
                await FoodDataCRUDServices.uploadFoodData(context, data);
                await context.read<FoodProvider>().getFoodData();
              },
              child: pressedAddFoodItemButton
                  ? CircularProgressIndicator(
                      color: white,
                    )
                  : Text(
                      'Add Food',
                      style: AppTextStyles.body16Bold.copyWith(color: white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
