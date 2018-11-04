import "package:flutter/material.dart";
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CrimeView extends StatefulWidget {
  @override
  _CrimeViewState createState() => _CrimeViewState();
}

class _CrimeViewState extends State<CrimeView> {

  File _image;

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? const Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}