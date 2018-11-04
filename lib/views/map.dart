
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import './report.dart';
import '../config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  LatLng position = LatLng(0.0, 0.0);
  StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    
    print("hello");
    Geolocator()
      .checkGeolocationPermissionStatus()
      .then((GeolocationStatus snapshot) {

        if (snapshot.index == GeolocationStatus.denied.index
          || snapshot.index == GeolocationStatus.disabled.index) {
            print('bummer');
            return;
        }
      });

    _positionStream = Geolocator()
      .getPositionStream(
        LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 100)
      )
      .listen((Position pos) {
        setState(() {
          position = LatLng(pos.latitude, pos.longitude);
        });
        print("position ${pos.latitude}, ${pos.longitude}");
      });

    super.initState();
  }

  @override
  void dispose() {

    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: position,
          zoom: 2.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': Config.MAPBOX_KEY ?? 'oopsies',
              'id': 'mapbox.streets',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: position,
                builder: (ctx) =>
                Container(
                  child: IconButton(
                    icon: Icon(Icons.person_pin),
                    iconSize: 48.0,
                    color: Colors.orange,
                    onPressed: () => {},
                  )
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => ReportView()
            )
          ),
        tooltip: 'Increment',
        icon: Icon(Icons.camera),
        label: Text("Report crime"),
        backgroundColor: Colors.red,
      ),
    );
  }
}

