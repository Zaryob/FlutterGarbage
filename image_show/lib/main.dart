import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/*
 * Add assests into pubspec.yaml as seen under flutter tag

 assets:
  - assets/profile.jpeg
 */

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Show',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image Show"),
        ),
        body: Center(
          child: Image.asset("profile.jpeg")
        )
      ),
    );
  }
}
