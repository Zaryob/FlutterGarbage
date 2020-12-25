import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp() ,
  ),
  );
}

enum GameCategoriesSettings { shooter, mmofps, pvp, mmorpg }

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GameCategoriesSettings gameCategoryThatShownInMainPage=null;
  String categoryName='';

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  //Loading category values
  _loadCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch(prefs.getInt('category') ?? 0){
        case 0:
          gameCategoryThatShownInMainPage=null;
          categoryName='';
          break;
        case 1:
          gameCategoryThatShownInMainPage=GameCategoriesSettings.shooter;
          categoryName='shooter';
          break;
        case 2:
          gameCategoryThatShownInMainPage=GameCategoriesSettings.mmofps;
          categoryName='mmofps';
          break;
        case 3:
          gameCategoryThatShownInMainPage=GameCategoriesSettings.pvp;
          categoryName='pvp';
          break;
        case 4:
          gameCategoryThatShownInMainPage=GameCategoriesSettings.mmorpg;
          categoryName='mmorpg';
          break;
      }
    });
  }

  //Change category after dropdown select
  _changeCat(GameCategoriesSettings value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int category;
    setState(() {
      switch(value){
        case GameCategoriesSettings.shooter:
          category=1;
          categoryName='shooter';
          break;
        case GameCategoriesSettings.mmofps:
          category=2;
          categoryName='mmofps';
          break;
        case GameCategoriesSettings.pvp:
          category=3;
          categoryName='pvp';
          break;
        case GameCategoriesSettings.mmorpg:
          category=4;
          categoryName='mmorpg';
          break;
      }
      prefs.setInt('category', category);

      gameCategoryThatShownInMainPage=value;
    });
  }

  @override
  Widget build(BuildContext context) {

    void handleClick(String value) async {
      switch (value) {
        case 'Settings':
          final result= await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute(cat: gameCategoryThatShownInMainPage)),
          );
          setState(() {
            // print(result);
            gameCategoryThatShownInMainPage=result;
            _changeCat(gameCategoryThatShownInMainPage);
          });
      }
    }

    return MaterialApp(
      title: 'Free To Play Games Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Free To Play Games Database'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder:  (context) {
                return {'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: JSONListView(category: categoryName),
      ),
    );
  }
}

class GetGames {
  String title;

  GetGames({
    this.title,
  });

  factory GetGames.fromJson(Map<String, dynamic> json) {
    return GetGames(
      title: json['title'],
    );
  }
}

class JSONListView extends StatefulWidget {
  final String category;
  JSONListView({Key key, @required this.category}) : super(key: key);
  _JSONListView createState() => _JSONListView();
}

class _JSONListView extends State<JSONListView> {

  final String mainAPIURL = 'https://www.freetogame.com/api/games/';
  String apiURL='';

  @override
  void initState() {
    super.initState();
  }

  Future<List<GetGames>> fetchJSONData(String category) async {

    if (category != ''){
      apiURL= mainAPIURL+ "?category=" + category;
    }
    else{
      apiURL=mainAPIURL;
    }
    // print(apiURL);
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
        future: fetchJSONData(widget.category),
        builder: (context, snapshot) {
          pushToFirebase(snapshot.data);
          //pushToFirebase();
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
        }
    );
  }

  // List<GetGames> data
  Future<void> pushToFirebase(List<GetGames> data) async {
    CollectionReference games=FirebaseFirestore.instance.collection("games");
    final gamesDocs = await games.get();
    Future<void> addGame(GetGames game){
      return games
          .add({'name': game.title})
          .then((value)=> print("Added game ${game.title}"))
          .catchError((error) => print("Failed to add game: $error") );
    }

    if(gamesDocs.docs.length == 0) { //If there isn't any collection under games
      for(GetGames game in data){
        addGame(game);
      }
    }
    else {
      print("Database already generated skipping...");
    }
  }


}

class SecondRoute extends StatefulWidget {
  final GameCategoriesSettings cat;
  SecondRoute({Key key, @required this.cat}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {

  GameCategoriesSettings _site = null;

  @override
  Widget build(BuildContext context) {
    if (_site ==  null){
      _site=widget.cat;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Shooter'),
            leading: Radio(
              value: GameCategoriesSettings.shooter,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Massively Multiplayer Online First-Person Shooter'),
            leading: Radio(
              value: GameCategoriesSettings.mmofps,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Player versus Player'),
            leading: Radio(
              value: GameCategoriesSettings.pvp,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Massively Multiplayer Online Role-Playing Game'),
            leading: Radio(
              value: GameCategoriesSettings.mmorpg,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                // get the text in the TextField and send it back to the FirstScreen
                if (_site ==null){
                  _site=widget.cat;
                }
                Navigator.pop(context, _site);
              },
              child: Text('Ok'),
          )
        ],
      ),
    );
  }
}
