import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quicknomsrestaurant/utils/colors.dart';
import 'package:quicknomsrestaurant/utils/textStyles.dart';
import 'package:quicknomsrestaurant/widgits/textfieldWidget.dart';
import 'package:sizer/sizer.dart';

class AddFoodItemScreen extends StatefulWidget {
  const AddFoodItemScreen({super.key});

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantLicenseNumberController =
      TextEditingController();

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
            Container(
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
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
