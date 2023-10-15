import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/location.dart';

class LocationService {
  LocationService();

  Future getPermession() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("err");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
    return await getLocation();
  }
}

Future getLocation() async {
  try {
    Position position;

    LocationModel location;
    var placemarks;
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    location = LocationModel(
        governorat: placemarks[0].administrativeArea,
        locality: placemarks[0].locality);

    return location;
  } catch (e) {
    return LocationModel(governorat: "N/A", locality: "N/A");
  }
}
