import "package:flutter/material.dart";
import 'dart:io';
import 'package:latlong/latlong.dart';
import 'package:image_picker/image_picker.dart';

class ReportView extends StatefulWidget {
  
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {

  File image;
  LatLng loc;

  @override
    void initState() {
      super.initState();

       ImagePicker.pickImage(source: ImageSource.camera).then((File f) {
        setState(() {
          image = f;
        });
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