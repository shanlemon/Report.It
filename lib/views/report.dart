import "package:flutter/material.dart";
import 'dart:io';
import 'package:latlong/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

import '../components/button_column.dart';

class ReportView extends StatefulWidget {
  
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {

  File image;
  LatLng latestLoc;
  String address = "";
  DateTime timestamp;
  int crimeType = 3;
  String description;
  int data;

  @override
    void initState() {
      super.initState();

       ImagePicker.pickImage(source: ImageSource.camera).then((File f) {
        setState(() {
          image = f;
        });
      });

      Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position pos) {

          setState(() { 
            latestLoc = LatLng(pos.latitude, pos.longitude);
            timestamp = new DateTime.now();
          });

          Geolocator()
            .placemarkFromCoordinates(pos.latitude, pos.longitude)
            .then((List<Placemark> place) {
              Placemark addr = place.first;

              setState(() { 
                address = (addr != null)
                  ?"${addr.subThoroughfare} ${addr.thoroughfare}, ${addr.locality},"
                  " ${addr.administrativeArea} ${addr.postalCode}, ${addr.country}"
                  : "";
              });
            });
        });

    }

    void submit() {
      FirebaseDatabase.instance.reference().child('reports')
        .push().set({
          'crime': crimeType,
          'description': description,
          'image': 'null', // TODO
          'latitude': latestLoc.latitude,
          'longitude': latestLoc.longitude,
          'timestamp': timestamp.millisecondsSinceEpoch,
          'address': address
        });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New report'),
      ),
      body: ListView(
        reverse: true,
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0)
            ),
            child: Center(
              child: image == null
                  ? const Text('No image selected.')
                  : Image.file(image,
                      height: 180.0,
                      width: 400.0,
                      fit: BoxFit.cover,
                    ),
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Text(address,
              textAlign: TextAlign.center,
              textScaleFactor: 1.6,
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonColumn((crimeType == 0), Icons.person, "Homicide", () => setState(() { crimeType = 0; })),
              ButtonColumn((crimeType == 1), Icons.person_pin, "Robbery", () => setState(() { crimeType = 1; })),
              ButtonColumn((crimeType == 2), Icons.directions_run, "Dispute", () => setState(() { crimeType = 2; })),
              ButtonColumn((crimeType == 3), Icons.do_not_disturb_alt, "Misc", () => setState(() { crimeType = 3; }))
            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (String s) => setState(() { description = s; }),
              maxLines: 4,
              maxLength: 80,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Please briefly describe what is occuring'
              ),
            )
          )
        ].reversed.toList()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submit, // update database
        tooltip: 'Publish',
        child: const Icon(Icons.file_upload),
      ),
    );
  }
}