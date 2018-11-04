import "package:flutter/material.dart";
import 'dart:io';
import 'package:latlong/latlong.dart';

class ReportView extends StatefulWidget {

  final Future<File> _image;
  final Future<LatLng> _loc;

  ReportView(this._loc, this._image);

  @override
  _ReportViewState createState() => _ReportViewState(_loc, _image);
}

class _ReportViewState extends State<ReportView> {

  final Future<File> _image;
  final Future<LatLng> _loc;

  File image;
  LatLng loc;

  _ReportViewState(this._loc, this._image);


  @override
    void initState() {
      super.initState();

      _image.then((File f) {
        setState(() {
          image = f;
        });
        print("\n\nImage loaded");
      });

      // _loc.then((LatLng l) {
      //   setState(() {
      //     loc = l; // used for tracking
      //   });
      // });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New report'),
      ),
      body: Center(
        child: image == null
            ? const Text('No image selected.')
            : Image.file(image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Done!'), // update database
        tooltip: 'Publish',
        child: const Icon(Icons.file_upload),
      ),
    );
  }
}