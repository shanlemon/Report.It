
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import './report.dart';
import '../config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  LatLng position = LatLng(29.834, -95.4342);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: position,
          zoom: 13.0,
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

// MarkerLayerOptions(
//   markers: [
//     Marker(
//       width: 80.0,
//       height: 80.0,
//       point: LatLng(29.834, -95.4342),
//       builder: (ctx) =>
//       Container(
//         child: IconButton(
//           icon: Icon(Icons.warning),
//           iconSize: 48.0,
//           color: Colors.orange,
//           onPressed: () => {},
//         )
//       ),
//     ),
//   ],
// ),
