import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Center(
          child:Text(highlight("highligted text")),
        )
      )
    );
  }
}

String highlight(String s) {
  return "***"+s+"***";
}

/* var x;
   x=5; //integer
   print(x); //puts 5
   x="Thellad"; //string
   print(x); //puts "Thellad" string
 */
