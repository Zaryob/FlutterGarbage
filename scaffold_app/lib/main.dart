import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("First scaffold theme"),
          elevation: 100, //Elevation
          brightness: Brightness.light, // elavations brigtness
        ),
        body: Center(
          child: Text("Hello Scaffold"),
        ),
        drawer: Drawer(
          child: Center(
            child: Text(
              "I'm drawer"
            ),
          ),
        ),
      ),
    );
  }
}