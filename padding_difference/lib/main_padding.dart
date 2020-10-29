import 'package:flutter/material.dart';
// this comes with padding
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Material(
        color: Colors.grey[50],
        child: Container(
          color: Colors.grey[500],
          padding: EdgeInsets.all(80.0),
          margin: EdgeInsets.all(40.0),
          child: Container(
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
