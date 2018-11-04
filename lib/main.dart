import 'package:flutter/material.dart';
import './Files/Camera.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Report It',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CameraApp(),
    );
  }
}