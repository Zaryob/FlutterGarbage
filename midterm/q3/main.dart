import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free To Play Games Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Free To Play Games Database'),
        ),
        body: JSONListView(),
      ),
    );
  }
}

class GetGames {
  int id;  // For controlling valnuebility
  String title;

  GetGames({
    this.id,
    this.title,
  });

  factory GetGames.fromJson(Map<String, dynamic> json) {
    return GetGames(
      id: json['id'],
      title: json['title'],
    );
  }
}

class JSONListView extends StatefulWidget {
  _JSONListView createState() => _JSONListView();
}

class _JSONListView extends State {

  final String apiURL = 'https://www.freetogame.com/api/games/';

  Future<List<GetGames>> fetchJSONData() async {

    var jsonResponse = await http.get(apiURL);

    if (jsonResponse.statusCode == 200) {

      final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

      List<GetGames> usersList = jsonItems.map<GetGames>((json) {
        return GetGames.fromJson(json);
      }).toList();

      return usersList;

    } else {
      throw Exception('Failed to load data from Free To Play Games Database');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetGames>>(
      future: fetchJSONData(),
      builder: (context, snapshot) {

         if (snapshot.hasError) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 70,
                    ),
                    Text("Opps... Something went wrong"),
                  ]
              )
          );
        }
         else if (!snapshot.hasData) {
           return Center(
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,

                   children: <Widget>[

                     CircularProgressIndicator(
                       semanticsLabel: "Awaiting results...",
                     ),
                     Text("Awaiting results..."),
                   ]
               )
           );
         }
        else {
          return ListView.separated(
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].title),
              );
            },
          );
        }
/*
This is implementation weith ListView
          return ListView(
            children: snapshot.data.map((game) => ListTile(
              title: Text(game.title),
              onTap: (){
                print(game.title); // For debugging
                },
            ),
            ).toList(),
          );

 */
      },


    );

  }
}