
import 'package:flutter/material.dart';

// this is without padding.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Material(
        color: Colors.grey[50],
        child: Container(
          color: Colors.grey[500],
          child: Container(
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
