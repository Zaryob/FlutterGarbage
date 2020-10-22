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
          title: Center(
            child: Text("Süleyman Poyraz"),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.deepOrangeAccent,
              ),
              Container(
                width: 180,
                height: 180,
                color: Colors.yellowAccent,
                padding: EdgeInsets.fromLTRB(48, 96, 0, 0),
                margin: EdgeInsets.fromLTRB(48, 96, 0, 0),
              ),
              Container(
                  child: Text(
                  "110510181",
                ),
                padding: EdgeInsets.fromLTRB(48, 84, 0, 0),
                margin: EdgeInsets.fromLTRB(48, 84, 0, 0),
              ),
            ],
          )
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: __sayHello,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
      )

    );
  }

  void __sayHello() {
    print("Welcome");
  }
}