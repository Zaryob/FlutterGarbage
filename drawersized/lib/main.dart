import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Question 2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 100.0, //with changing that place, we can change header
              child: DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              height: 150.0,
              child:ListTile(
                  title: Text('Item 1- Over Sized'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
            ),
            ListTile(
              title: Text('Item 2- Normal size (unsized)'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
                height: 10.0,
                child:ListTile(
                  title: Text('Item 3- Under Sized'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}