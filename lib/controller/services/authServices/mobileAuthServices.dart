import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';
import 'package:quicknomsrestaurant/controller/provider/authProvider/authProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quicknomsrestaurant/view/authScreens/mobileLoginScreen.dart';
import 'package:quicknomsrestaurant/view/authScreens/otpScreen.dart';
import 'package:quicknomsrestaurant/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:quicknomsrestaurant/view/restaurantRegistrationScreen/restaurantRegistrationScreen.dart';
import 'package:quicknomsrestaurant/view/signInLogicScreen/signInLogicScreen.dart';

class MobileAuthServices {
  static checkRestaurantRegistration({required BuildContext context}) async {
    bool restaurantIsRegistered = false;
    try {
      await firestore
          .collection('Restaurant')
          .where('restaurantUID', isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0
            ? restaurantIsRegistered = true
            : restaurantIsRegistered = false;
        log('Restraunt is Registered = $restaurantIsRegistered');
        if (restaurantIsRegistered) {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const BottomNavigationBarQuickNoms(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const RestaurantRegistrationScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false,
          );
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileLoginScreen()),
          (route) => false);
      return false;
    }
    checkRestaurantRegistration(context: context);
    return true;
  }

  static recieveOTP(
      {required BuildContext context, required String mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: mobileNo,
          verificationCompleted: (PhoneAuthCredential credentials) {
            log(credentials as String);
          },
          verificationFailed: (FirebaseAuthException exception) {
            log(exception as String);
            throw Exception(exception);
          },
          codeSent: (String verificationID, int? resendToken) {
            context
                .read<MobileAuthProvider>()
                .updateVerificationID(verificationID);
            Navigator.push(
                context,
                PageTransition(
                    child: const OTPScreen(),
                    type: PageTransitionType.rightToLeft));
          },
          codeAutoRetrievalTimeout: (String verificationID) {});
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static verifyOTP({required BuildContext context, required String otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
              child: const SignInLogicScreen(),
              type: PageTransitionType.rightToLeft));
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
