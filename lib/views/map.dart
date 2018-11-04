
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../components/crime_marker.dart';

import './report.dart';
import '../config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  LatLng position = LatLng(29.7215442, -95.3403587);
  StreamSubscription<Position> _positionStream;
  List<CrimeMarker> crimes;
  List<Marker> crimeMarkers;

  IconData getIcon(int crimeType) {
    if (crimeType == 0)
      return Icons.person;
    else if (crimeType == 1)
      return Icons.person_pin;
    else if (crimeType == 2)
      return Icons.directions_run;
    else if (crimeType == 3)
      return Icons.do_not_disturb_alt;
    else
      return Icons.people;
  }

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


      FirebaseDatabase.instance.reference().child('reports')
        .orderByChild('crime')
        .startAt(0).endAt(3)
        .onValue.listen((Event e) {
          Map<dynamic, dynamic> x = e.snapshot.value as Map<dynamic, dynamic>;
          List<CrimeMarker> y = x.keys.map((dynamic k) => CrimeMarker.fromJSON(x[k.toString()])).toList();
          
          setState(() {
            crimes = y;
            crimeMarkers = y.map((CrimeMarker m) => Marker(
              width: 80.0,
              height: 80.0,
              point: m.location,
              builder: (ctx) =>
                Container(
                  child: IconButton(
                    icon: Icon(getIcon(m.crime)),
                    iconSize: 48.0,
                    color: Colors.red,
                    onPressed: () => showDialog(
                      context: ctx,
                      builder: (ctx2) => Container(
                          padding: EdgeInsets.only(bottom: 150.0, top: 150.0, left: 50.0, right: 50.0),
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Container(child: Image.network(m.image ?? "https://proxy.duckduckgo.com/iur/?f=1&image_host=https%3A%2F%2Fstyletips101.com%2Fwp-content%2Fuploads%2F2017%2F03%2Fpotato.png&u=https://media.styletips101.com/2017/03/potato.png", width: 400.0,
                      fit: BoxFit.cover), width: 300.0, height: 150.0),
                                
                                Icon(
                                  getIcon(m.crime),
                                  size: 48.0,
                                ),
                                Text(m.address ?? "null",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.6
                                  )
                              ],
                            ),
                        )
                      )
                    )
                  )
                )
            )).toList();
          });
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
          zoom: 16.0,
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
            markers: List.from(crimeMarkers ?? [])..add(
              Marker(
                width: 80.0,
                height: 80.0,
                point: position,
                builder: (ctx) =>
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.person_pin),
                      iconSize: 48.0,
                      color: Colors.blue,
                      onPressed: () => {},
                    )
                  ),
              )
            ),
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

