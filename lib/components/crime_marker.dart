
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class CrimeMarker extends StatelessWidget {

  final LatLng location;
  final String image;
  final String description;
  final int timestamp;
  final int crime;


  CrimeMarker({this.location, this.image, this.description, this.timestamp, this.crime});

  factory CrimeMarker.fromJSON(Map<dynamic, dynamic> parsedJson) {

    return CrimeMarker(
      location: LatLng(parsedJson['latitude'], parsedJson['longitude']),
      image: parsedJson['image'],
      description: parsedJson['description'],
      timestamp: parsedJson['timestamp'],
      crime: parsedJson['crime']
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}