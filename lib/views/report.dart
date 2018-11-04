import "package:flutter/material.dart";
import 'dart:io';
import 'package:latlong/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import '../components/button_column.dart';

class ReportView extends StatefulWidget {
  
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {

  File image;
  LatLng latestLoc;
  String address = "";

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
          });

          Geolocator()
            .placemarkFromCoordinates(pos.latitude, pos.longitude)
            .then((List<Placemark> place) {
              Placemark addr = place.first;
              address = (addr != null)
                ?"${addr.subThoroughfare} ${addr.thoroughfare}, ${addr.locality},"
                " ${addr.administrativeArea} ${addr.postalCode}, ${addr.country}"
                : "";
            });
        });

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New report'),
      ),
      body: Column(
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
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(address,
              textAlign: TextAlign.center,
              textScaleFactor: 1.6,
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonColumn(false, Icons.person, "Homicide"),
              ButtonColumn(false, Icons.person_pin, "Robbery"),
              ButtonColumn(false, Icons.directions_run, "Dispute"),
              ButtonColumn(false, Icons.do_not_disturb_alt, "Misc")
            ],
          )
        ],
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Done!'), // update database
        tooltip: 'Publish',
        child: const Icon(Icons.file_upload),
      ),
    );
  }
}