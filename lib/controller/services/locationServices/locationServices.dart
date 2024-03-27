import 'dart:developer';

import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quicknomsrestaurant/constant/constant.dart';

class LocationServices {
  static getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        getCurrentLocation();
      }
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    log(currentPosition.toString());

    return currentPosition;
  }

  static registerRestaurantLocationInGeofire(String restaurantUID) async {
    Position currentLocation = await getCurrentLocation();
    GeoFirePoint myLocation = geo.point(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude);
    firestore
        .collection('location')
        .add({'restaurantUID': restaurantUID, 'position': myLocation.data});
  }
}
