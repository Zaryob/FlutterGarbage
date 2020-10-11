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
          title: Text('More Widgets Demo'),
        ),
        body: Center(
        child: Column(
          children: [
            Text("Hello_World", textScaleFactor: 2.0,),
            Text("Inside of the hello world."),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      )
    )


    );
  }
}