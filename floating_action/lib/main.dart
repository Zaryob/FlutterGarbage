import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floating Action',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
    String __pressedOrNot="You havent pressed button";
    int counter=0;
    void __changeText(){
      counter++;
      setState(__getNewText);
    }
    void __getNewText(){
      __pressedOrNot="You have pressed button $counter times";
    }

    Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child: Text(__pressedOrNot),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: __changeText,
        ),
      );
    }

}
