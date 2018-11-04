
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class CrimeMarker extends StatelessWidget {

  final LatLng location;
  final String image;
  final String description;
  final int timestamp;
  final int crime;
  final String address;


  CrimeMarker({this.location, this.image, this.description, this.timestamp, this.crime, this.address});

  factory CrimeMarker.fromJSON(Map<dynamic, dynamic> parsedJson) {

    return CrimeMarker(
      location: LatLng(parsedJson['latitude'], parsedJson['longitude']),
      image: parsedJson['image'],
      description: parsedJson['description'],
      timestamp: parsedJson['timestamp'],
      crime: parsedJson['crime'],
      address: parsedJson['address'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}