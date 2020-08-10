import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';


Future<String> getCountryName() async {
  Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  debugPrint('location: ${position.latitude}');
  final coordinates = new Coordinates(position.latitude, position.longitude);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(
      coordinates);
  var first = addresses.first;
  debugPrint('Country: ${first.countryCode.toLowerCase()}');
  return first.countryCode.toLowerCase();
}