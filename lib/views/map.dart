
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import './crime.dart';
import '../config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: FlutterMap(
      options: new MapOptions(
        center: new LatLng(29.834, -95.4342),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': Config.MAPBOX_KEY ?? 'oopsies',
            'id': 'mapbox.streets',
          },
        ),
      ],
    ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
            new MaterialPageRoute(
              builder: (context) => new CrimeView()
            )
          ),
        tooltip: 'Increment',
        icon: Icon(Icons.camera),
        // label: Text("Report crime"),
        label: Text(Config.TEST ?? 'no good'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

// new MarkerLayerOptions(
//   markers: [
//     new Marker(
//       width: 80.0,
//       height: 80.0,
//       point: new LatLng(29.834, -95.4342),
//       builder: (ctx) =>
//       new Container(
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
